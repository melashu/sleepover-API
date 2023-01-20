class User < ApplicationRecord
  has_many :hotels
  has_many :reservations
  has_may :rooms, through: :reservations
end
