class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_create :update_reservation

  private
  def update_reservation
    room.update(reserve: true)
  end
end
