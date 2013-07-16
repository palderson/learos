class CreateMarketings < ActiveRecord::Migration
  def change
    create_table :marketings do |t|
      t.text :description
      t.references :project

      t.timestamps
    end
    add_index :marketings, :project_id
  end
end
