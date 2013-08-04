class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscription_plan
  attr_accessible :subscription_plan_id, :stripe_card_token, :user_id

  attr_accessor :stripe_card_token, :coupon

  # def update_plan(role)
  #   self.role_ids = []
  #   self.add_role(role.name)
  #   unless customer_id.nil?
  #     customer = Stripe::Customer.retrieve(customer_id)
  #     customer.update_subscription(:plan => role.name)
  #   end
  #   true
  # rescue Stripe::StripeError => e
  #   logger.error "Stripe Error: " + e.message
  #   errors.add :base, "Unable to update your subscription. #{e.message}."
  #   false
  # end

  def update_stripe
    return if user.email.include?(ENV['ADMIN_EMAIL'])
    return if user.email.include?('@example.com') and not Rails.env.production?
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
      customer.save
    end
    self.last_4_digits = customer.cards.first.last4
    self.stripe_customer_token = customer.id
    self.stripe_card_token = nil
    self.expire_date = DateTime.now + 1.month
    save!
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "#{e.message}."
    self.stripe_token = nil
    false
  end

  # def cancel_subscription
  #   unless customer_id.nil?
  #     customer = Stripe::Customer.retrieve(customer_id)
  #     unless customer.nil? or customer.respond_to?('deleted')
  #       if customer.subscription.status == 'active'
  #         customer.cancel_subscription
  #       end
  #     end
  #   end
  # rescue Stripe::StripeError => e
  #   logger.error "Stripe Error: " + e.message
  #   errors.add :base, "Unable to cancel your subscription. #{e.message}."
  #   false
  # end

  def expire
    UserMailer.expire_email(self).deliver
    destroy
  end
end
