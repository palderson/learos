module Integrations
  class JiraController < ApplicationController
    before_filter :find_jira

    def edit
    end

    def update
      if @jira.update_attributes(params[:jira].merge({user_id: current_user.id}))
        generate_key_file(@jira.private_key)
        redirect_to new_jira_session_path
      else
        render :edit
      end
    end

    def verify
      if @jira.update_attributes(params[:jira])
        redirect_to jira_authorize_path(oauth_verifier: @jira.oauth_verifier)
      else
        render :edit
      end
    end

    def find_jira
      @jira = current_user.jira
    end

    private
    def generate_key_file(content)
      target = 'rsakey.pem'
      File.open(target, "w+") {|f| f.write(content) }
    end
  end
end
