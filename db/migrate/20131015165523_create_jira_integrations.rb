class CreateJiraIntegrations < ActiveRecord::Migration
  def change
    create_table :jira_integrations do |t|
      t.string :jira_site_url
      t.string :jira_consumer_key
      t.text :jira_private_key
      t.belongs_to :user

      t.timestamps
    end
  end
end
