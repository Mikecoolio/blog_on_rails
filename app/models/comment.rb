class Comment < ApplicationRecord
    validates :body, presence: true, length: {minimum: 3, maximum: 255}
    belongs_to :post
    belongs_to :user, optional: true
end
