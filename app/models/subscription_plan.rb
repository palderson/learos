class SubscriptionPlan < ActiveRecord::Base
  has_many :subscriptions
  attr_accessible :name, :number_of_projects, :price
end
