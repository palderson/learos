class AddJiraProjectKeyToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :jira_project_key, :string
  end
end
