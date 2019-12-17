class User < ApplicationRecord
  validates :email, presence: true, email: true, uniqueness: true
  has_many :pins
  has_many :comments
end
