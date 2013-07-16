class CreateRollouts < ActiveRecord::Migration
  def change
    create_table :rollouts do |t|
      t.text :description
      t.references :project

      t.timestamps
    end
    add_index :rollouts, :project_id
  end
end
