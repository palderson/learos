class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.text :ideal_client
      t.string :applicable_client_percentage
      t.text :client_motivations
      t.string :target_budget
      t.string :purchase_decision_maker
      t.string :product_user
      t.references :project
      t.timestamps
    end
    add_index :profiles, :project_id
  end
end
