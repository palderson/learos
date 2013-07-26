class CollaborationsController < ApplicationController
  def index

  end

  def new
    @project = Project.find(params[:project_id])
    @collaboration = @project.collaborations.new
  end
end
