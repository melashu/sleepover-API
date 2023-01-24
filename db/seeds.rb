# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user = User.create!(name: 'lawrence', username: 'lawrence', email: 'law@gmail.com', password: '12345678' )
hotel = Hotel.create(name: 'HIP', country: 'Ghana', phone: '+233', city: 'Accra', user_id: user.id)
room = Room.create(room_no: 2, number_of_bed: 3, photo: 'sm.jpg', prices: 23.00, user_id: user.id, hotel_id: hotel.id )
