class Comment < ApplicationRecord
  validates :body, presence: true, length: { maximum: 500 }
  
  belongs_to :pin
  belongs_to :user
end
