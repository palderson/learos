class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :sub_check
 
  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.projects.unarchived

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    get_jira_data
    
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
    # arams[:project][:jira_id] = current_user.jira.id if params[:project][:jira_project_key].present? && current_user.jira.access_key.present? && current_user.jira.access_token.present?
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
    get_jira_data
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
  
  def get_jira_data
    if @project.jira.present?
      jira = @project.jira
      options = {
        :site => jira.site_url,
        :context_path => '',
        :private_key_file => 'rsakey.pem',
        :consumer_key => jira.consumer_key
      }
      @jira_client = JIRA::Client.new(options)
      @jira_client.set_access_token(jira.access_token, jira.access_token)
      @jira_data = @jira_client.Project.find(@project.jira_project_key) if @project.jira_project_key.present?
    end
  end
  
  private
  def sub_check
    redirect_to root_path, alert: 'Subscribe to view/edit projects!' unless check_subscription_status
  end


end
