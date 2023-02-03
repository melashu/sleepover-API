class AddDetailToHotels < ActiveRecord::Migration[7.0]
  def change
    add_column :hotels, :detail, :text
  end
end
