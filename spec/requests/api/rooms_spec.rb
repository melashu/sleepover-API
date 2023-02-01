require 'swagger_helper'

RSpec.describe 'Rooms', type: :request do
    path '/api/v1/rooms' do
        get 'Retrieves all rooms' do
          tags 'Rooms'
          description 'Retrieves all rooms (only logged in users or admin can retrieve rooms) by recieving token with the request that is sent as response body after login'
          produces 'application/json'
          
          response '200', 'rooms retrieved' do
            run_test!
    
            before do
              @admin = User.create( name:'admin', role: 'admin', email: 'admin@example.com', password: 'password', username: 'admin')
              @hotel = Hotel.create({ name: 'Hotel Name', city: 'New York', country: 'United States', phone: '+1234567890', image: 'https://example.com/hotel.jpg', user_id: @admin.id, details: 'This is a great hotel.'})
            	@room = Room.create([{ room_no: 21, number_of_bed: 3, prices: 23.0, photo: 'https://example.com/hotel.jpg', user_id: @admin.id, hotel_id: hotel.id}])
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
                 reserve: { type: :boolean},
                 user_id:{ type: :integer },
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
					tags 'Rooms'
					description 'Add new room (only logged in admin can add new room) by recieving token with the request that is sent as response body after login'
					consumes 'application/json'
					parameter name: :room, in: :body, schema: { 
						type: :array,
               type: :object,
               properties: {
                 id: { type: :integer },
                 room_no: { type: :integer },
                 number_of_bed: { type: :integer },
                 prices: { type: :decimal },
                 photo: { type: :string },
                 reserve: { type: :boolean},
                 user_id:{ type: :integer },
                 hotel_id: { type: :integer }
                },
								required: %w[id room_no number_of_bed image prices photo reserve user_id hotel_id]
               }
				
					response '201', 'room added' do
						run_test!
		
						before do
							@admin = User.create( name:'admin', role: 'admin', email: 'admin@example.com', password: 'password', username: 'admin')
							@hotel = Hotel.create({ name: 'Hotel Name', city: 'New York', country: 'United States', phone: '+1234567890', image: 'https://example.com/hotel.jpg', user_id: @admin.id, details: 'This is a great hotel.'})
						end
						let(:room) do
							{ room_no: 21, number_of_bed: 3, prices: 23.0, photo: 'https://example.com/hotel.jpg', user_id: @admin.id, hotel_id: hotel.id}
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
