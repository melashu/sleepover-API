class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Hotel
    can :manage, :all

    return unless user.present?

    if user.is? :admin
      can :manage, :all
    else
      can %i[read update delete], User, id: user.id
      can :read, Reservation, user_id: user.id
      can :create, Reservation
      can :delete, Reservation do |reserved|
        reserved.start_date < Date.now
      end

      can :read, Room
      can :read, Hotel

    end

    # return unless user.present?

    # can(%i[read update delete], User, user:)
    # can %i[read update delete], User, user: user
    # can(:read, Room, user:)

    # can(%i[create read], Reservation, user:)

    # return unless user.admin?

    # can :manage, :all

    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
