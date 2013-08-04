class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    end
    can :create, :all if user.has_free_projects? && (user.has_subscribed? || user.has_trial_days?)
    can :invite, Project do |project|
      !user.is_invited?(project)
    end
  end
end
