module Integrations
  class JiraController < ApplicationController
    before_filter :find_jira, only: :destroy

    def index
    end

    def new
      @jira = Jira.new
    end

    def create
      add_keys_to_params
      @jira = Jira.new(params[:jira].merge({user_id: current_user.id}))

      if @jira.save
        generate_key_file(@jira.private_key, @jira.site_url)
        redirect_to integrations_jira_index_path
      else
        render :new
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
    def add_keys_to_params
      keys = SSHKey.generate
      params[:jira][:private_key] = keys.private_key
      params[:jira][:public_key] = keys.public_key
      params[:jira][:consumer_key] = SecureRandom.hex(16)
    end
    
    def generate_key_file(content, site)
      target = "#{Rails.root}/public/system/jira_keys/#{current_user.email.parameterize}/#{site.parameterize}"
      FileUtils::mkdir_p(target)
      File.open(target + "/rsakey.pem", "w+") {|f| f.write(content) }
    end
  end
end
