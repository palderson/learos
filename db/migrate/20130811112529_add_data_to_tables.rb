class AddDataToTables < ActiveRecord::Migration
  def change
    add_column :overviews, :data, :hstore
    add_hstore_index :overviews, :data
  end
end
