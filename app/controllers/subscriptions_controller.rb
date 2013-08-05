class SubscriptionsController < ApplicationController
  before_filter :find_subscription

  def new
  end

  def edit
  end

  def update
    if params[:subscription][:update_stripe] == '0' && @subscription.stripe_customer_token.present? && params[:subscription][:subscription_plan_id] != @subscription.subscription_plan.id
      @subscription.update_plan(params[:subscription][:subscription_plan_id])
      redirect_to projects_path, notice: "Successfully changed plan to #{@subscription.subscription_plan.name.titleize}."
    else
      @subscription.update_attributes(params[:subscription].merge(user_id: current_user.id))
      if @subscription.update_stripe
        redirect_to projects_path, notice: "Thank you for subscribing to #{@subscription.subscription_plan.name.titleize}."
      else
        render :edit
      end
    end
  end

  def find_subscription
    @user = current_user
    @subscription = @user.subscriptions.first
  end
end
