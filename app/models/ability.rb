class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    can :destroy, Post, author_id: user.id # Allow users to delete their own posts

    if user.role == "admin" # Check if the user has an admin role
      can :destroy, Post # Allow admins to delete any post
    end
  end
end
