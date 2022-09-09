class User < ApplicationRecord
    has_many :comments, dependent: :destroy
    has_many :posts, dependent: :destroy

    validates :email, presence: true, uniqueness: true
    validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
