  require 'swagger_helper'

# # RSpec.describe 'Hotels API', type: :request do
# #   let(:admin) { create(:user, role: 'admin', email: 'admin@example.com', password: 'password', confirmed_at: Time.now, username: 'admin') }
# #   let(:valid_attributes) { { name: 'Test Hotel', city: 'Test City', country: 'Test Country', phone: '1234567890', image: 'image.jpg', user_id: @admin.id, details: 'Test Details' } }
# #   let(:invalid_attributes) { { name: '', city: '', country: '', phone: '', image: '', user_id: '', details: '' } }
# #   let(:auth_headers) { sign_in(admin) }

# #   path '/hotels' do
# #     post 'Creates a new hotel' do
# #       before do
# #         headers = auth_headers
# #       end
# #       parameter name: :hotel, in: :body, schema: {
# #         type: :object,
# #         properties: {
# #           hotel: {
# #             type: :object,
# #             properties: {
# #               name: { type: :string },
# #               city: { type: :string },
# #               country: { type: :string },
# #               phone: { type: :string },
# #               image: { type: :string },
# #               user_id: { type: :integer },
# #               details: { type: :string },
# #             },
# #             required: [ 'name', 'city', 'country', 'phone', 'image', 'user_id', 'details' ]
# #           }
# #         }
# #       }

# #       response '200', 'hotel created' do
# #         let(:hotel) { valid_attributes }
# #         run_test! do
# #           expect(response.body).to include_json(hotel.to_json)
# #         end
# #       end

# #       response '422', 'invalid request' do
# #         let(:hotel) { invalid_attributes }
# #         run_test!
# #       end
# #     end
# #   end
# # end

# # RSpec.describe 'Hotels API', type: :request do
# # 	let(:admin) { create(:user, role: 'admin', email: 'admin@example.com', password: 'password', confirmed_at: Time.now, username: 'admin') }
# #   let!(:hotels) { create_list(:hotel, 5, name: 'Hotel Name', city: 'New York', country: 'United States', phone: '+1234567890', image: 'https://example.com/hotel.jpg', user_id: @admin.id, details: 'This is a great hotel.') }
# #   let(:auth_headers) { sign_in(admin) }
# #   path '/api/v1/hotels' do
# #       before do
# #       	headers = auth_headers
# #       end
# #       get 'Retrieves all hotels' do
# #           tags 'Hotels'
# #           produces 'application/json'
# #           # parameter name: :Authorization, in: :header, type: :string, required: true
# #           response '200', 'hotels retrieved' do
# #               run_test! do |response|
# #                   expect(response.body).to match_array(hotels)
# #                   end
# #               end
# #           response '401', 'Unauthorized' do
# #               let(:headers) { invalid_headers }
# #               run_test!
# #           end
# #       end
# #   end
# # end

# RSpec.describe 'Hotels API', type: :request do
#   let(:admin) { create(:user, name: 'admin',role: 'admin', email: 'admin@example.com', password: 'password', username: 'admin') }
#   let!(:hotels) { create_list(:hotel, 5, name: 'Hotel Name', city: 'New York', country: 'United States', phone: '+1234567890', image: 'https://example.com/hotel.jpg', user_id: @admin.id, details: 'This is a great hotel.') }
#   let(:auth_headers) { { 'Authorization': "Bearer #{token}"} }
#   let(:invalid_headers) { { 'Authorization': nil } }
#   before(:each) do
#     post '/auth/login', params: { email: 'admin@example.com', password: 'password' }
#     token = JSON.parse(response.body)['token']
#   end
#   path '/api/v1/hotels' do
#       get 'Retrieves all hotels' do
#           tags 'Hotels'
#           produces 'application/json'
#           headers auth_headers
#           response '200', 'hotels retrieved' do
#               run_test! do |response|
#                   expect(response.body).to match_array(hotels)
#                   end
#               end
#           response '401', 'Unauthorized' do
#               let(:headers) { invalid_headers }
#               run_test!
#           end
#       end
#   end
# end

RSpec.describe 'Hotels', type: :request do
  
  # let(:headers) { { 'Authorization': "Bearer #{jwt_encode(user_id: @admin.id)}" } }

  # before(:each) do
  #   post '/auth/login', params: { email: 'admin@example.com', password: 'password' }
  #   @object = JSON.parse(response.body)
  #   @token = @object.token
  # end


  path '/api/v1/hotels' do
    get 'Retrieves all hotels' do
      tags 'Hotels'
      description 'Retrieves all hotels (only logged in users can retrieve hotels) by recieving token with the request that is sent as response body after login'
      produces 'application/json'

      response '200', 'hotels retrieved' do
        run_test!
        
        before do
          @admin = User.create( name:'admin', role: 'admin', email: 'admin@example.com', password: 'password', username: 'admin')
          @hotel = Hotel.create( [{name: 'Hotel Name', city: 'New York', country: 'United States', phone: '+1234567890', image: 'https://example.com/hotel.jpg', user_id: @admin.id, details: 'This is a great hotel.'},
          { name: 'Hotel Name', city: 'city', country: 'country', phone: '+1234567877', image: 'https://example.com/hotel.jpg', user_id: @admin.id, details: 'hotel detals.'}])
        end
        schema type: :array,
        items: {
          type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            city: { type: :string },
            country: { type: :string },
            phone: { type: :string },
            image: { type: :string },
            details: { type: :string }
          },
          required: %w[id name image city country phone details]
        }
  
      end
     
      response '401', 'Unauthorized' do
        let(:headers) { invalid_parameters }
        run_test!
      end
    end
  end
end
