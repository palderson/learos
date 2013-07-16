class CreateBillings < ActiveRecord::Migration
  def change
    create_table :billings do |t|
      t.text :description
      t.references :project

      t.timestamps
    end
    add_index :billings, :project_id
  end
end
