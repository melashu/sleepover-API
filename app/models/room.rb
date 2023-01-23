class Room < ApplicationRecord
  belongs_to :hotel
  has_many :reservations
  has_many :users, through: :reservations
  # has_many_and_belogs

  validates :prices, presence: true
  validates :number_of_bed, presence: true
  validates :photo, presence: true
end
