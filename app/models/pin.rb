class Pin < ApplicationRecord
  validates :title, presence: true
  validates :image_url, presence: true
  validates :tag, length: { maximum: 30 }
  belongs_to :user
end
