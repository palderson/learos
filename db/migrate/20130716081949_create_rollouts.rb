class CreateRollouts < ActiveRecord::Migration
  def change
    create_table :rollouts do |t|
      t.text :what_went_well
      t.text :what_could_have_gone_better
      t.text :what_surprised_you
      t.text :lesson_learned
      t.references :project
      t.timestamps
    end
    add_index :rollouts, :project_id
  end
end
