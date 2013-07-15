class GoalsController < ApplicationController
  before_filter :find_project

  def create
    @goal = Goal.new(params[:goal])

    respond_to do |format|
      if @project.goals.create(params[:goal])
        format.html { redirect_to @project, notice: 'Goal was successfully created.' }
        format.json { render json: @project, status: :created, location: @goal }
      end
    end
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end
end
