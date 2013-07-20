class CreateClientTrainings < ActiveRecord::Migration
  def change
    create_table :client_trainings do |t|
      t.string :company_training_materials
      t.string :user_training_materials
      t.references :project

      t.timestamps
    end
    add_index :client_trainings, :project_id
  end
end
