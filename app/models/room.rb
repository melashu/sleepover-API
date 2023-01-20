class Room < ApplicationRecord
  belongs_to :hotel
  has_many :reservations
  has_may :users, through: :reservations
  # has_many_and_belogs
end
