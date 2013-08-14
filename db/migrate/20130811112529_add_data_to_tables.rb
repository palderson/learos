class AddDataToTables < ActiveRecord::Migration
  def change
    add_column :overviews, :data, :hstore
    add_hstore_index :overviews, :data
    add_column :goals, :data, :hstore
    add_hstore_index :goals, :data
    add_column :profiles, :data, :hstore
    add_hstore_index :profiles, :data
    add_column :products, :data, :hstore
    add_hstore_index :products, :data
    add_column :marketings, :data, :hstore
    add_hstore_index :marketings, :data
    add_column :billings, :data, :hstore
    add_hstore_index :billings, :data
    add_column :onboardings, :data, :hstore
    add_hstore_index :onboardings, :data
    add_column :servicings, :data, :hstore
    add_hstore_index :servicings, :data
    add_column :plans, :data, :hstore
    add_hstore_index :plans, :data
    add_column :internal_trainings, :data, :hstore
    add_hstore_index :internal_trainings, :data
    add_column :rollouts, :data, :hstore
    add_hstore_index :rollouts, :data
    add_column :client_trainings, :data, :hstore
    add_hstore_index :client_trainings, :data
    add_column :test_clients, :data, :hstore
    add_hstore_index :test_clients, :data
  end
end
