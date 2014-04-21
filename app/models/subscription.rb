class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscription_plan
  attr_accessible :subscription_plan_id, :update_stripe, :stripe_card_token, :user_id

  default_scope { order('created_at DESC') }

  attr_accessor :update_stripe, :stripe_card_token, :coupon

  def update_plan(plan_id)
    self.subscription_plan_id = plan_id
    raise Stripe::StripeError.new("Archive or delete projects to downgrade") unless can_downgrade?(user)
    unless stripe_customer_token.nil?
      customer = Stripe::Customer.retrieve(stripe_customer_token)
      customer.update_subscription(:plan => plan_id)
      self.expire_date = Time.at(customer.subscription.current_period_end.to_i)
      self.status = "active"
      save!
    end
    true
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to update your subscription. #{e.message}."
    false
  end

  def update_stripe
    return if user.email.include?(ENV['ADMIN_EMAIL'])
    return if user.email.include?('@example.com') and not Rails.env.production?
    raise Stripe::StripeError.new("Archive or delete projects to downgrade") unless can_downgrade?(user)
    if stripe_customer_token.nil?
      unless stripe_card_token.present?
        raise "Stripe token not present. Can't create account."
      end
      if coupon.blank?
        customer = Stripe::Customer.create(
          :email => user.email,
          :description => user.name,
          :card => stripe_card_token,
          :plan => subscription_plan.id
        )
      else
        customer = Stripe::Customer.create(
          :email => user.email,
          :description => user.name,
          :card => stripe_card_token,
          :plan => subscription_plan.id,
          :coupon => coupon
        )
      end
    else
      customer = Stripe::Customer.retrieve(stripe_customer_token)
      if stripe_card_token.present?
        customer.card = stripe_card_token
      end
      customer.email = user.email
      customer.description = user.name
      customer.update_subscription(:plan => self.subscription_plan.id)
      customer.save
    end
    self.last_4_digits = customer.cards.first.last4
    self.stripe_customer_token = customer.id
    self.stripe_card_token = nil
    self.expire_date = Time.at(customer.subscription.current_period_end.to_i)
    self.status = "active"
    save!
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "#{e.message}."
    self.stripe_card_token = nil
    false
  end

  def can_downgrade?(user)
    user.projects.unarchived.count <= self.subscription_plan.number_of_projects
  end

  def cancel_subscription
    unless stripe_customer_token.nil?
      customer = Stripe::Customer.retrieve(stripe_customer_token)
      unless customer.nil? or customer.respond_to?('deleted')
        if customer.subscription.status == 'active'
          customer.cancel_subscription
          self.status = "canceled"
          save!
        end
      end
    end
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to cancel your subscription. #{e.message}."
    false
  end

  def expire
    UserMailer.expire_email(self).deliver
    destroy
  end
end
