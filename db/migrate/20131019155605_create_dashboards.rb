class CreateDashboards < ActiveRecord::Migration
  def change
    create_table :dashboards do |t|
     t.references :project

     t.timestamps
    end
    add_index :dashboards, :project_id
  end
end