class SubscriptionsController < ApplicationController
  before_filter :find_subscription

  def new
  end

  def edit
  end

  def update
    if @subscription.stripe_customer_token.present? && params[:subscription][:subscription_plan_id] != @subscription.subscription_plan.id
      @subscription.update_plan(params[:subscription][:subscription_plan_id])
    end
    @subscription.update_attributes(params[:subscription].merge(user_id: current_user.id))
    if @subscription.update_stripe
      redirect_to root_path, notice: 'Thank you for subscribing!'
    else
      render :edit
    end
  end

  def find_subscription
    @user = current_user
    @subscription = @user.subscriptions.first
  end
end
