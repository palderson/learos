class CreateTestClients < ActiveRecord::Migration
  def change
    create_table :test_clients do |t|
      t.string :client_1
      t.string :client_2
      t.string :client_3
      t.references :project

      t.timestamps
    end
    add_index :test_clients, :project_id
  end
end
