class Billing < ActiveRecord::Base
  belongs_to :project
  attr_accessible :payment_processing_method, :billing_process_steps, :billing_update_requirements, :contract_requirements

  acts_as_commentable
end
