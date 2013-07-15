class CreateOverviews < ActiveRecord::Migration
  def change
    create_table :overviews do |t|
      t.string :description
      t.references :project

      t.timestamps
    end
    add_index :overviews, :project_id
  end
end
