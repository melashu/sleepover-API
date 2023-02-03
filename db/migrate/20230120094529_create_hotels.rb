class CreateHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :city
      t.string :phone
      t.references :user, null: false, foreign_key: true
      t.string :country

      t.timestamps
    end
  end
end
