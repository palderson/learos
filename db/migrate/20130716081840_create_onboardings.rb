class CreateOnboardings < ActiveRecord::Migration
  def change
    create_table :onboardings do |t|
      t.text :description
      t.references :project

      t.timestamps
    end
    add_index :onboardings, :project_id
  end
end
