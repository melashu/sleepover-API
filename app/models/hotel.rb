class Hotel < ApplicationRecord
  belongs_to :user
  has_many :rooms, dependent: :destroy

  has_one_attached :image
end
