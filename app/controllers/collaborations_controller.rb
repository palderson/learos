class CollaborationsController < ApplicationController
  before_filter :find_project

  def index
    authorize!(:invite, @project)
    @collaborations = @project.collaborations
  end

  def new
    @project = Project.find(params[:project_id])
    @collaboration = @project.collaborations.new
  end

  def create
    @user = find_or_invite_user(params[:collaboration][:email], params[:collaboration][:name])
    if @user.valid? && @user.email != current_user.email
      @collaboration = @project.collaborations.create(user_id: @user.id)
      redirect_to @project, notice: 'User successfully invited!'
    else
      redirect_to new_project_collaboration_path(@project), notice: 'Please enter valid information!'
    end
  end

  def destroy
    authorize!(:invite, @project)
    @collaboration = @project.collaborations.find(params[:id])
    @collaboration.destroy

    redirect_to project_collaborations_path(@project), notice: 'Collaborator was successfully removed.'
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

private
  def find_or_invite_user(email, name)
    User.where(email: email).first || User.invite!({email: email, name: name}, current_user)
  end
end
