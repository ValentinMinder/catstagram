class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)
    
    if user.has_role?(:admin)
        # may read everything
        can :read, :all
        # may manage all users (not admins, but himself)
        can :manage, User do |useralt|
            !useralt.has_role?(:admin) || useralt.id==user.id
        end

        # may manage photos, cats, hashtags from everywhere
        can :manage, Photo
        can :manage, Cat
        can :manage, Hashtag

        # only admin can see and change roles (fully blocked for users)
        can :manage, Role
        can :manage_role, User

        # reset report of photos, only of others
        can :reset_report_photo, Photo do |photo|
            photo.user_id != user.id
        end

        # only admin can see and change banned status
        can :see_banned, User
        can :change_banned, User
    end

    if user.has_role?(:user)
        # user may manage their own profile, photos, cats
        # user can see banned status, but can't change banned status!
        can :see_banned, User
        can :manage, User do |useralt|
            user.id == useralt.id
        end
        can :manage, Photo do |photo|
            photo.user_id == user.id
        end
        can :manage, Cat do |cat|
            cat.user_id == user.id
        end

        # user may create hashtags, cats, photos
        can :create, Hashtag
        can :create, Cat
        can :create, Photo

        # can like & report photos, only of others
        # WARNING: calling with can? will work to disable buttons
        # HOWEVER, 
        can :like_photo, Photo do |photo|
            photo.user_id != user.id
        end
        can :report_photo, Photo do |photo|
            photo.user_id != user.id
        end
    end

    if user.has_role?(:tester)
        can :test, User
        can :test, Photo
        can :test, Cat
        can :test, Hashtag
        can :test, Role
    end

    # everyone (guest) can read specified models
    can :read, User
    can :read, Photo
    can :read, Cat
    can :read, Hashtag
  end
end
