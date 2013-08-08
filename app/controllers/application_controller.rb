class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def check_subscription_status
    subscription = current_user.subscription
    return false if subscription.status == 'canceled'
    return true if current_user.has_trial_days? && subscription.status.nil?
    if current_user.subscription.expire_date.to_date == DateTime.now.to_date
      customer = Stripe::Customer.retrieve(subscription.stripe_customer_token)
      if customer.subscription
        subscription.expire_date = Time.at(customer.subscription.current_period_start.to_i)
        subscription.save!
        true
      else
        subscription.status = 'canceled'
        subscription.save!
        false
      end
    else
      true
    end
  end
end
