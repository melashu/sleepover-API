class Hotel < ApplicationRecord
  belongs_to :user
  has_many :rooms

  has_one_attached :image
end
