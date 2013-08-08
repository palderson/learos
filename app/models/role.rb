class Role < ActiveRecord::Base
  has_and_belongs_to_many :subscriptions, :join_table => :subscriptions_roles
  belongs_to :resource, :polymorphic => true
  
  scopify
end
