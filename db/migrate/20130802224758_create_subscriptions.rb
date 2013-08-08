class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :stripe_customer_token
      t.string :status
      t.datetime :expire_date
      t.integer :last_4_digits
      t.references :user

      t.timestamps
    end
    add_index :subscriptions, :user_id
  end
end
