class Pin < ApplicationRecord
  validates :title, presence: true
  validates :image_url, presence: true
  validates :tag, length: { maximum: 30 }
  belongs_to :user
  has_many :comments

  def self.most_recent
    all.order(created_at: :desc).limit(6)
  end

  def self.search(query)
    database_query = "%#{query}%"
    where('title LIKE ?', database_query).or(where('tag LIKE ?', database_query))
  end

  def comments_invert
    comments.reverse
  end
end
