class Project < ActiveRecord::Base
  attr_accessible :title, :dashboard_attributes, :overview_attributes, :collaboration_attributes, :user_id

  belongs_to :user
  has_one :dashboard, dependent: :destroy
  has_one :overview, dependent: :destroy
  has_many :collaborations, dependent: :destroy
  store_accessor :data

  acts_as_commentable
  accepts_nested_attributes_for :dashboard, :overview

  scope :unarchived, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }

  after_create do
    self.create_dashboard
    self.create_overview
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
