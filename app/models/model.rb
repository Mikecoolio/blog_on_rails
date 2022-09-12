# ability.rb
class Ability 
    include CanCan::Ability

    def initialize(user)
        user ||= User.new

        if user.is_admin?
            can :manage, :all
        end

        alias_action :create, :read, :update, :destroy, to: :crud

        can :crud, User do |user|
            user == user
        end

        can :crud, Post do |post|
            user == post.user
        end

        can :crud, Comment do |comment|
            user == comment.user

        end
    end
end

# application_record.rb
class ApplicationRecord < ActiveRecord::Base
    primary_abstract_class
end

# comment.rb
class Comment < ApplicationRecord
    validates :body, presence: true, length: {minimum: 3, maximum: 255}
    belongs_to :post
    belongs_to :user, optional: true
end

# post.rb
class Post < ApplicationRecord
    validates :title, presence: true, uniqueness: true
    validates :body, presence: true, length: { minimum: 50 }

    has_many :comments, dependent: :destroy
    belongs_to :user, optional: true
end

# user.rb
class User < ApplicationRecord
    has_secure_password

    has_many :comments, dependent: :nullify
    has_many :posts, dependent: :nullify

    validates :email, presence: true, uniqueness: true
    validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

    def full_name(first_name, last_name)
        first_name + " " + last_name
    end
end
