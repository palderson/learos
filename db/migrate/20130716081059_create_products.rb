class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :description
      t.references :project

      t.timestamps
    end
    add_index :products, :project_id
  end
end
