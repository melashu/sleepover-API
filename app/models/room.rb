class Room < ApplicationRecord
  belongs_to :hotel
  has_many :reservations
  has_many :users, through: :reservations

  has_one_attached :photo
  # has_many_and_belogs
end
