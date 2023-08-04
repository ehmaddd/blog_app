class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    if user.admin?
      can :manage, :all
    else
      can :manage, Post, author: user
      can :manage, Comment, author: user
      can :read, :all
    end
  end
end
