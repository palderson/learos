class CreateOnboardings < ActiveRecord::Migration
  def change
    create_table :onboardings do |t|
      t.text :step_one      
      t.text :step_two      
      t.text :step_three
      t.text :step_four
      t.text :step_five
      t.references :project
      t.timestamps
    end
    add_index :onboardings, :project_id
  end
end
