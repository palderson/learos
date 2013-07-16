class TestClientsController < ApplicationController
  before_filter :find_project

  def create
    @test_client = TestClient.new(params[:test_client])

    respond_to do |format|
      if @project.test_clients.create(params[:test_client])
        format.html { redirect_to @project, notice: 'Test Client was successfully created.' }
        format.json { render json: @project, status: :created, location: @goal }
      end
    end
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end
end
