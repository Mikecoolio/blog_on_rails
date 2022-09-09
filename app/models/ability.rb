class Ability 
    include CanCan::Ability

    def initialize(user)
        user ||= User.new
        can :manage, :all
    end

    alias_action :create, :read, :update, :destroy, to: :crud

    can :crud, User do |a_user|
        user == a_user
    end

    can :crud, Post do |post|
        user == post.user
    end

    can :crud, Comment do |comment|
        user == comment.user
    end
end