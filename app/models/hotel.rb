class Hotel < ApplicationRecord
  belongs_to :user
  has_many :rooms, dependent: :destroy

  has_one_attached :image
  validates :image, presence: true
  validates :country, presence: true
  validates :city, presence: true
  validates :name, presence: true
  validates :phone, presence: true
  validates :detail, presence: true
end
