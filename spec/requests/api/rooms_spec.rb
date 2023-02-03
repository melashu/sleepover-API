require 'swagger_helper'

RSpec.describe 'Rooms', type: :request do
  path '/api/v1/rooms' do
    get 'Retrieves all rooms' do
      tags 'Rooms'
      description 'Returns all rooms (only logged in user or admin can retrieve rooms) by recieving token with request'
      produces 'application/json'

      response '200', 'rooms retrieved' do
        run_test!

        before do
          @ad = User.create(name: 'ad', role: 'ad', email: 'ad@som', password: 'password', username: 'ad')
          @hot = Hotel.create({ name: 'H', city: 'Yo', country: 'S', phone: '1', image: '.j', user_id: @ad.id,
                                details: 'hotel.' })
          @ro = Room.create([{ room_no: 2, number_of_bed: 3, prices: 3, photo: 'hotel.jpg', user_id: @adm.id,
                               hotel_id: hot.id }])
        end
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   room_no: { type: :integer },
                   number_of_bed: { type: :integer },
                   prices: { type: :decimal },
                   photo: { type: :string },
                   reserve: { type: :boolean },
                   user_id: { type: :integer },
                   hotel_id: { type: :integer }
                 },
                 required: %w[id room_no number_of_bed image prices photo reserve user_id hotel_id]
               }
      end

      response '401', 'Unauthorized' do
        let(:headers) { invalid_parameters }
        run_test!
      end
    end
  end
  path '/api/v1/rooms' do
    post 'Add new room' do
      tags 'Rooms only logged in admin can add new room'
      consumes 'application/json'
      parameter name: :room, in: :body,
                schema: {
                  type: :object, properties: { id: { type: :integer }, room_no: { type: :integer },
                                               number_of_bed: { type: :integer }, prices: { type: :decimal },
                                               photo: { type: :string }, reserve: { type: :boolean },
                                               user_id: { type: :integer }, hotel_id: { type: :integer } },
                  required: %w[room_no number_of_bed image prices photo user_id hotel_id]
                }

      response '201', 'room added' do
        run_test!

        before do
          @ad = User.create(name: 'adm', role: 'adm', email: 'adm@example', password: 'password', username: 'adm')
          @h = Hotel.new({ name: 'H', city: 'Y', country: 'S', phone: '1', image: 'h', user_id: @ad.id, details: 'h' })
        end
        let(:room) do
          { room_no: 21, number_of_bed: 3, prices: 23.0, photo: 'https:', user_id: @ad.id, hotel_id: @h.id }
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
