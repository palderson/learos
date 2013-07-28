class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    else
      can :view, :silver if user.has_role? :silver
      can :view, :gold if user.has_role? :gold
      can :view, :platinum if user.has_role? :platinum
    end
    can :create, :all if user.has_free_projects? && (user.has_subscribed? || user.has_trial_days?)
    can :invite, Project do |project|
      !user.is_invited?(project)
    end
  end
end
