class SubscriptionsController < ApplicationController
  before_filter :find_subscription

  def new
  end

  def edit
  end

  def update
    if params[:subscription][:update_stripe] == '0' && @subscription.stripe_customer_token.present? && params[:subscription][:subscription_plan_id] != @subscription.subscription_plan.id
      @subscription.update_plan(params[:subscription][:subscription_plan_id])
    else
      @subscription.update_attributes(params[:subscription].merge(user_id: current_user.id))
      unless @subscription.update_stripe
        render :edit
      end
    end
    redirect_to projects_path, notice: "Successfully subscribed to #{@subscription.subscription_plan.name.titleize} plan."
  end

  def find_subscription
    @user = current_user
    @subscription = @user.subscriptions.first
  end
end
