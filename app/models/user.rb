class User < ApplicationRecord
  has_many :hotels
  has_many :reservations
  has_many :rooms, through: :reservations
end
