class CreateSubscriptionPlans < ActiveRecord::Migration
  def change
    create_table :subscription_plans do |t|
      t.string :name
      t.decimal :price
      t.integer :number_of_projects

      t.timestamps
    end
  end
end
