class CreateInternalTrainings < ActiveRecord::Migration
  def change
    create_table :internal_trainings do |t|
      t.text :description
      t.references :project

      t.timestamps
    end
    add_index :internal_trainings, :project_id
  end
end
