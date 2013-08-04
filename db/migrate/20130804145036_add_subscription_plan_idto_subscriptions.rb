class AddSubscriptionPlanIdtoSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :subscription_plan_id, :integer
    add_index :subscriptions, :subscription_plan_id
  end
end
