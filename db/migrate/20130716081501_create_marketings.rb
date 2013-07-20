class CreateMarketings < ActiveRecord::Migration
  def change
    create_table :marketings do |t|
      t.text :overview
      t.text :external_messaging
      t.text :internal_messaging
      t.string :marketing_budget
      t.text :alpha_invite_email
      t.text :beta_invite_email
      t.references :project

      t.timestamps
    end
    add_index :marketings, :project_id
  end
end
