class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable, :invitable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :stripe_token, :coupon
  attr_accessor :stripe_token, :coupon

  has_many :subscriptions
  has_many :projects
  has_many :collaborations
  after_create :create_subscription

  def current_subscription
    subscriptions.first
  end

  def create_subscription
    self.subscriptions.create
  end

  def get_plan
    current_subscription.stripe_customer_token.present? ? current_subscription.subscription_plan.name : 'trial'
  end

  def has_free_projects?
    plan = get_plan
    return true if (plan == 'platinum' || plan == 'trial')
    Project.get_max_projects(self) - self.projects.count > 0 ? true : false
  end

  def has_subscribed?
    return true if current_subscription.stripe_customer_token.present?
    return false
  end

  def has_trial_days?
    trial_days_count > 0
  end

  def trial_days_count
    30 - (DateTime.now.to_date - self.created_at.to_date).to_i
  end

  def is_invited?(project)
    project.collaborations.map(&:user).include?(self)
  end
end
