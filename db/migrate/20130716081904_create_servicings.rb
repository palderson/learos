class CreateServicings < ActiveRecord::Migration
  def change
    create_table :servicings do |t|
      t.text :description
      t.references :project

      t.timestamps
    end
    add_index :servicings, :project_id
  end
end
