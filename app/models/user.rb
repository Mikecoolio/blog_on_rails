class User < ApplicationRecord
    has_secure_password

    has_many :comments, dependent: :nullify
    has_many :posts, dependent: :nullify

    validates :email, presence: true, uniqueness: true
    validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
