class CreateClientTrainings < ActiveRecord::Migration
  def change
    create_table :client_trainings do |t|
      t.text :description
      t.references :project

      t.timestamps
    end
    add_index :client_trainings, :project_id
  end
end
