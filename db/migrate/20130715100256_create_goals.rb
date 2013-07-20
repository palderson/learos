class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.text :six_week_goals
      t.text :three_month_goals
      t.text :six_month_goals
      t.references :project

      t.timestamps
    end
    add_index :goals, :project_id
  end
end
