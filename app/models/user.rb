class User < ApplicationRecord
  validates :email, presence: true, email: true, uniqueness: true

  has_many :pins
  has_many :comments
  has_and_belongs_to_many :pinboard_pins, class_name: 'Pins'
end
