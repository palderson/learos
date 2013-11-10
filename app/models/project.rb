class Project < ActiveRecord::Base
  attr_accessible :title, :overview_attributes, :goal_attributes, :test_client_attributes, :profile_attributes, :product_attributes, :marketing_attributes, :billing_attributes, :onboarding_attributes, :servicing_attributes, :plan_attributes, :internal_training_attributes, :client_training_attributes, :rollout_attributes, :collaboration_attributes, :jira_project_key, :jira_id, :user_id

  belongs_to :user
  belongs_to :jira
#  has_one :dashboard, dependent: :destroy
  has_one :overview, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_one :product, dependent: :destroy
  has_one :goal, dependent: :destroy
  has_one :marketing, dependent: :destroy
  has_one :billing, dependent: :destroy
  has_one :test_client, dependent: :destroy
  has_one :onboarding, dependent: :destroy
  has_one :servicing, dependent: :destroy
  has_one :plan, dependent: :destroy
  has_one :internal_training, dependent: :destroy
  has_one :client_training, dependent: :destroy
  has_one :rollout, dependent: :destroy
  has_many :collaborations, dependent: :destroy
  accepts_nested_attributes_for :profile, :product, :billing, :marketing, :onboarding, :servicing, :plan, :internal_training, :client_training, :rollout, :goal, :test_client, :collaborations

  scope :unarchived, where(archived: false)
  scope :archived, where(archived: true)

  after_create do
#    self.create_dashboard
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

  # After data field is added to all models: empty data attributes when all data fields are removed
  # def update_attributes(attributes)
  #   if attributes.is_a?(Hash)
  #     attributes.each {|attr| attr.last["data"] = nil unless attr.last["data"] }
  #     super(attributes)
  #   end
  # end
end
