class CreateBillings < ActiveRecord::Migration
  def change
    create_table :billings do |t|
      t.text :payment_processing_method
      t.text :billing_process_steps
      t.text :billing_update_requirements      
      t.text :contract_requirements
      t.references :project

      t.timestamps
    end
    add_index :billings, :project_id
  end
end
