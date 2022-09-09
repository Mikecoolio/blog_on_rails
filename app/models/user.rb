class User < ApplicationRecord
    attr_accessor :password, :password_confirmation
    validates :password, presence: true, confirmation: true
    
    has_many :comments, dependent: :nullify
    has_many :posts, dependent: :nullify

    validates :email, presence: true, uniqueness: true
    validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
