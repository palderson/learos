class Project < ActiveRecord::Base
  attr_accessible :title, :overview_attributes, :profile_attributes, :product_attributes, :marketing_attributes, :billing_attributes, :onboarding_attributes, :servicing_attributes, :plan_attributes, :internal_training_attributes, :client_training_attributes, :rollout_attributes

  has_one :overview
  has_one :profile
  has_one :product
  has_many :goals
  has_one :marketing
  has_one :billing
  has_many :test_clients
  has_one :onboarding
  has_one :servicing
  has_one :plan
  has_one :internal_training
  has_one :client_training
  has_one :rollout
  accepts_nested_attributes_for :overview, :profile, :product, :billing, :marketing, :onboarding, :servicing, :plan, :internal_training, :client_training, :rollout

  after_create do
    self.create_overview
    self.create_profile
    self.create_product
    self.create_marketing
    self.create_billing
    self.create_onboarding
    self.create_servicing
    self.create_plan
    self.create_internal_training
    self.create_client_training
    self.create_rollout
  end
end
