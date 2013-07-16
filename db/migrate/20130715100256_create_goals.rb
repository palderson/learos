class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.text :description
      t.references :project

      t.timestamps
    end
    add_index :goals, :project_id
  end
end