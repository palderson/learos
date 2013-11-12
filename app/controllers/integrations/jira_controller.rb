module Integrations
  class JiraController < ApplicationController
    before_filter :find_jira, only: :destroy

    def index
    end

    def new
      @jira = Jira.new
    end

    def create
      @jira = Jira.new(params[:jira].merge({user_id: current_user.id}))
      
      if @jira.save
        generate_key_file(@jira.private_key)
        redirect_to integrations_jira_connect_path(jira: { connect_to: @jira.id })
      else
        render :new
      end
    end
    
    def edit
    end

    def update
      if @jira.update_attributes(params[:jira].merge({user_id: current_user.id}))
        generate_key_file(@jira.private_key)
        redirect_to integrations_jira_connect_path
      else
        render :edit
      end
    end

    def destroy
      @jira.destroy
      redirect_to integrations_jira_index_path
    end

    def find_jira
      @jira = Jira.find(params[:id])
    end

    private
    def generate_key_file(content)
      target = 'rsakey.pem'
      File.open(target, "w+") {|f| f.write(content) }
    end
  end
end
