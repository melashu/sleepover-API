require 'swagger_helper'

RSpec.describe 'Reservations', type: :request do
  path '/api/v1/reservations' do
    get 'Retrieves all Reservations' do
      tags 'Reservations'
      description 'Retrieves all reservations (only for the logged in user or admin can retrieve all his/her reservations) by recieving token with the request that is sent as response body after login'
      produces 'application/json'

      response '200', 'reservations retrieved' do
        run_test!

        before do
          @admin = User.create(name: 'admin', role: 'admin', email: 'admin@example.com', password: 'password',
                               username: 'admin')
          @hotel = Hotel.create({ name: 'Hotel Name', city: 'New York', country: 'United States',
                                  phone: '+1234567890', image: 'https://example.com/hotel.jpg', user_id: @admin.id, details: 'This is a great hotel.' })
          @room = Room.create({ room_no: 21, number_of_bed: 3, prices: 23.0,
                                photo: 'https://example.com/hotel.jpg', user_id: @admin.id, hotel_id: hotel.id })
          @reservation = Reservation.create([{ room_id: @room.id, user_id: @admin.id, start_date: time.now,
                                               end_date: time.now + 30_000, archived: true }])
        end
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   room_id: { type: :integer },
                   start_date: { type: :date },
                   end_date: { type: :date },
                   archived: { type: :boolean },
                   user_id: { type: :integer },
                   hotel_id: { type: :integer }
                 },
                 required: %w[id room_id start_date end_date archived user_id hotel_id]
               }
      end

      response '401', 'Unauthorized' do
        let(:headers) { invalid_parameters }
        run_test!
      end
    end
  end
  path '/api/v1/reservations' do
    post 'Add new resrvation' do
      tags 'Reservations'
      description 'Add new resrvation (only logged in admin can add new resrvation) by recieving token with headers that which is a response body of login'
      consumes 'application/json'
      parameter name: :resrvation, in: :body, schema: {
        type: :object, properties: { id: { type: :integer }, room_id: { type: :integer }, start_date: { type: :date },
                                     end_date: { type: :date }, archived: { type: :boolean }, user_id: { type: :integer },
                                     hotel_id: { type: :integer } },
        required: %w[id room_id start_date end_date archived user_id hotel_id]
      }

      response '201', 'resrevation added' do
        run_test!

        before do
          @admin = User.create(name: 'admin', role: 'admin', email: 'admin@example.com', password: 'password',
                               username: 'admin')
          @hotel = Hotel.create({ name: 'Hotel Name', city: 'New York', country: 'United States', phone: '+1234567890',
                                  image: 'https://example.com/hotel.jpg', user_id: @admin.id, details: 'This is a great hotel.' })
          @room = Room.create({ room_no: 21, number_of_bed: 3, prices: 23.0, photo: 'https://example.com/hotel.jpg',
                                user_id: @admin.id, hotel_id: hotel.id })
        end
        let(:reservation) do
          { room_id: @room.id, user_id: @admin.id, start_date: time.now, end_date: time.now + 30_000,
            archived: true }
        end
      end

      response '401', 'Unauthorized' do
        let(:headers) { invalid_parameters }
        run_test!
      end

      response '422', 'Not created' do
        let(:body) { invalid_parameters }
        run_test!
      end
    end
  end
end
