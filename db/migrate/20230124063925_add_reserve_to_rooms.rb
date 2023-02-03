class AddReserveToRooms < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :reserve, :boolean, default: false
  end
end
