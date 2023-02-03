class AddHotelToRooms < ActiveRecord::Migration[7.0]
  def change
    add_reference :rooms, :hotel, null: false, foreign_key: true
  end
end
