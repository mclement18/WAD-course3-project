class Pin < ApplicationRecord
  validates :title, presence: true
  validates :image_url, presence: true
  validates :tag, length: { maximum: 30 }
  belongs_to :user

  def self.most_recent
    all.order(created_at: :desc).limit(6)
  end
end
