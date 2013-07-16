class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.text :description
      t.references :project

      t.timestamps
    end
    add_index :plans, :project_id
  end
end
