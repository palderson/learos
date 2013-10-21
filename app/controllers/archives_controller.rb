class ArchivesController < ApplicationController
  before_filter :authenticate_user!, :sub_check

  def index
    @projects = current_user.projects.archived
  end

  def unarchive
    @project = Project.find(params[:archive_id])
    authorize! :invite, @project
    if can_unarchive?(current_user)
      @project.archived = false
      @project.save!
      redirect_to projects_path, notice: 'Project successfully unarchived.'
    else
      redirect_to projects_path, alert: 'Delete/archive active projects or upgrade plan to unarchive.'
    end
  end

private
  def sub_check
    redirect_to root_path, alert: 'Subscribe to view/edit projects!' unless check_subscription_status
  end

  def can_unarchive?(user)
    if user.subscription.subscription_plan
      user.projects.unarchived.count < user.subscription.subscription_plan.number_of_projects
    else
      true
    end
  end
end
