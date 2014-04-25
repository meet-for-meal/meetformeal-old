class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all                   # allow everyone to read everything
    if user && user.is_admin?
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :manage, :all               # do anything
      can :dashboard                  # allow access to dashboard
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
