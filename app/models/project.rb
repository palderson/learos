class Project < ActiveRecord::Base
  attr_accessible :title, :overview_attributes, :goal_attributes, :test_client_attributes, :profile_attributes, :product_attributes, :marketing_attributes, :billing_attributes, :onboarding_attributes, :servicing_attributes, :plan_attributes, :internal_training_attributes, :client_training_attributes, :rollout_attributes, :user_id

  belongs_to :user
  has_one :overview
  has_one :profile
  has_one :product
  has_one :goal
  has_one :marketing
  has_one :billing
  has_one :test_client
  has_one :onboarding
  has_one :servicing
  has_one :plan
  has_one :internal_training
  has_one :client_training
  has_one :rollout
  has_many :collaborations
  accepts_nested_attributes_for :overview, :profile, :product, :billing, :marketing, :onboarding, :servicing, :plan, :internal_training, :client_training, :rollout, :goal, :test_client

  after_create do
    self.create_overview
    self.create_profile
    self.create_product
    self.create_goal
    self.create_marketing
    self.create_billing
    self.create_onboarding
    self.create_servicing
    self.create_test_client
    self.create_plan
    self.create_internal_training
    self.create_client_training
    self.create_rollout
  end

  def self.get_max_projects(user)
    plan = user.get_plan
    return 3 if plan == 'silver'
    return 10 if plan == 'gold'
    return 'Unlimited' if plan == 'platinum' || plan == 'trial'
  end
end
