class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.text :description
      t.references :project

      t.timestamps
    end
    add_index :profiles, :project_id
  end
end
