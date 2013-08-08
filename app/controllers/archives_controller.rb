class ArchivesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @projects = current_user.projects.archived
  end

  def unarchive
    @project = Project.find(params[:archive_id])
    authorize! :invite, @project
    @project.archived = false
    @project.save!
    redirect_to projects_path, notice: 'Project successfully unarchived.'
  end
end
