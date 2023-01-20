class User < ApplicationRecord
  require 'securerandom'
  has_secure_password

  has_many :hotels
  has_many :reservations
  has_many :rooms, through: :reservations

  validates :name, presence: true, length: { in: 6..45 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { in: 6..30 }
  validates :username, presence: true, uniqueness: true, length: { in: 4..25 }
end
