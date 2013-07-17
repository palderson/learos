class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.projects
    @projects_info = get_remaining_projects
    @trial_info = get_remaining_days unless current_user.has_subscribed?
    @show = show_upgrade_message?

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  def create
    authorize! :create, current_user
    @project = Project.create!(params[:project].merge(user_id: current_user.id))

    respond_to do |format|
      format.html { redirect_to @project, notice: 'Project was successfully created.' }
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private
  def get_remaining_projects
    "#{current_user.projects.count} of #{Project.get_max_projects(current_user).to_s} Projects"
  end

  def get_remaining_days
    "#{current_user.trial_days_count.to_i} remaining trial days"
  end

  def show_upgrade_message?
    plan = current_user.get_role
    return true if current_user.has_subscribed? && (plan == 'silver' || plan == 'gold')
    return true if !current_user.has_subscribed? && current_user.has_trial_days?
  end
end
