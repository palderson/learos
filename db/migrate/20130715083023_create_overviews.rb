class CreateOverviews < ActiveRecord::Migration
  def change
    create_table :overviews do |t|
      t.text :elevator_pitch
      t.text :value_proposition
	  t.text :internal_motivations
      t.references :project

      t.timestamps
    end
    add_index :overviews, :project_id
  end
end
