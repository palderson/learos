module Integrations
  class JiraConnectController < ApplicationController
    before_filter :get_jira_client

    def connect
      request_token = @jira_client.request_token
      session[:request_token] = request_token.token
      session[:request_secret] = request_token.secret

      redirect_to request_token.authorize_url
    end

    def authorize
      request_token = @jira_client.set_request_token(
        session[:request_token], session[:request_secret]
      )
      access_token = @jira_client.init_access_token(
        :oauth_verifier => params[:oauth_verifier]
      )

      @jira.update_attributes({access_token: access_token.token, access_key: access_token.secret, verified: true })

      session.delete(:request_token)
      session.delete(:request_secret)

      redirect_to projects_path
    end

    def destroy
      session.data.delete(:jira_auth)
    end

    def verify
      redirect_to integrations_jira_authorize_path(oauth_verifier: params[:jira][:oauth_verifier], jira: { connect_to: @jira.id })
    end

    def get_jira_client
      @jira = Jira.find(params[:jira][:connect_to])
      options = {
        :site => @jira.site_url,
        :context_path => '',
        :private_key_file => 'rsakey.pem',
        :consumer_key => @jira.consumer_key
      }

      @jira_client = JIRA::Client.new(options)
    end
  end
end
