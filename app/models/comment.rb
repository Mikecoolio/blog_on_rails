class Comment < ApplicationRecord
    validates :body, presence: true, length: { maximum: 255, minimum: 3 }
    belongs_to :post
    belongs_to :user
end
