class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.integer :room_no
      t.integer :number_of_bed
      t.string :photo
      t.decimal :prices
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
