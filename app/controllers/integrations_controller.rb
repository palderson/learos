class IntegrationsController < ApplicationController
  def index
  end

  def new
    @integration = eval "#{params[:to].titleize}Integration.new"
  end

  def create
    @integration = eval "#{params[:to].titleize}Integration.new(params[:integration])"
    @integration.user = current_user
    if @integration.save
      redirect_to user_integrations_path(current_user)
    else
      render :new
    end
  end

end
