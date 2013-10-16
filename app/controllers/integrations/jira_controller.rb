module Integrations
  class JiraController < ApplicationController
    before_filter :find_jira, :get_jira_client

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
      @jira.update_attributes({ access_token: nil, access_key: nil })
      render :edit
    end

    def verify
      redirect_to integrations_jira_authorize_path(oauth_verifier: params[:jira][:oauth_verifier])
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
