class CreateTestClients < ActiveRecord::Migration
  def change
    create_table :test_clients do |t|
      t.string :first
      t.string :second
      t.string :third
      t.references :project

      t.timestamps
    end
    add_index :test_clients, :project_id
  end
end
