class AddArchivedToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :archived, :boolean, default: false
  end
end
