class JiraIntegration < ActiveRecord::Base
  attr_accessible :jira_consumer_key, :jira_private_key, :jira_site_url, :user_id
  validates :jira_consumer_key, :jira_private_key, :jira_site_url, presence: :true

  belongs_to :user
end
