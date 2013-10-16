class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  rescue_from JIRA::OauthClient::UninitializedAccessTokenError do
    redirect_to new_jira_session_url
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

private

  def get_jira_client
    jira = current_user.jira
    if jira.site_url && jira.consumer_key && jira.private_key
      # add any extra configuration options for your instance of JIRA,
      # e.g. :use_ssl, :ssl_verify_mode, :context_path, :site
      options = {
        :site => current_user.jira.site_url,
        :context_path => '',
        :private_key_file => 'rsakey.pem',
        :consumer_key => current_user.jira.consumer_key
      }

      @jira_client = JIRA::Client.new(options)

      # Add AccessToken if authorised previously.
      if jira.access_token && jira.access_key
        @jira_client.set_access_token(
          jira.access_token, jira.access_key
        )
      end
    end
  end
end
