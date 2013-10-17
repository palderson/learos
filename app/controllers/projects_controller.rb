class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :sub_check
  before_filter :get_jira_client, only: :show

  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.projects.unarchived
    @collaborations = current_user.collaborations.map(&:project).select { |p| p.archived == false }
    @projects_info = get_remaining_projects(@projects.count)
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
    @jira_data = @jira_client.Project.find(@project.jira_project_key) if @project.jira_project_key && current_user.jira.access_token && current_user.jira.access_key

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
    authorize! :edit, @project, message: "Unarchive the project to edit."
  end

  def create
    authorize! :create, current_user
    @project = Project.create!(params[:project].merge(user_id: current_user.id))

    respond_to do |format|
      format.html { redirect_to edit_project_path @project, notice: 'Project was successfully created.' }
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])
    authorize! :edit, @project, message: "Unarchive the project to edit."

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
    authorize! :invite, @project
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  def settings
    @project = Project.find(params[:project_id])
    authorize! :invite, @project
    render "settings"
  end

  def comments
    @project = Project.find(params[:project_id])
    authorize! :edit, @project, message: "Unarchive the project to add comments."
    @comment = Comment.build_from(@project.send(params[:model]), current_user.id, params[:body])
    if @comment.save
      redirect_to @project, notice: 'Comment was successfully added.'
    else
      redirect_to @project, notice: 'Unable to add comment. Check your input.'
    end
  end

  def archive
    @project = Project.find(params[:project_id])
    authorize! :invite, @project
    @project.archived = true
    @project.save!
    redirect_to projects_path, notice: 'Project successfully archived.'
  end

  private
  def sub_check
    redirect_to root_path, alert: 'Subscribe to view/edit projects!' unless check_subscription_status
  end

  def get_remaining_projects(num)
    "#{num} of #{Project.get_max_projects(current_user).to_s} Projects"
  end

  def get_remaining_days
    "#{current_user.trial_days_count.to_i} remaining trial days"
  end

  def show_upgrade_message?
    plan = current_user.get_plan
    return true if current_user.has_subscribed? && (plan == 'silver' || plan == 'gold')
    return true if !current_user.has_subscribed? && current_user.has_trial_days?
  end
end
