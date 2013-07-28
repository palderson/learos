class CollaborationsController < ApplicationController
  before_filter :find_project, :check_auth

  def index
    @collaborations = @project.collaborations
  end

  def new
    @project = Project.find(params[:project_id])
    @collaboration = @project.collaborations.new
  end

  def create
    @user = find_or_invite_user(params[:collaboration][:email])
    @collaboration = @project.collaborations.create(user_id: @user.id)
    redirect_to @project, notice: 'User successfully invited!'
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

  def check_auth
    authorize!(:invite, @project)
  end

private
  def find_or_invite_user(email)
    User.where(email: email).first || User.invite!({email: email}, current_user)
  end
end
