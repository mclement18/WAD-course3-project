class User < ApplicationRecord
  validates :email, presence: true, email: true, uniqueness: true
end
