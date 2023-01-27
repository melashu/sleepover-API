require 'swagger_helper'

describe 'Hotels API', type: :request do
  let(:admin) { create(:user, role: 'admin', email: 'admin@example.com', password: 'password', confirmed_at: Time.now) }
  let(:valid_attributes) { { name: 'Test Hotel', city: 'Test City', country: 'Test Country', phone: '1234567890', image: 'image.jpg', user_id: admin.id, details: 'Test Details' } }
  let(:invalid_attributes) { { name: 'Doe', city: "Doe's city", country: "Doe's country", phone: '+98776', image: "Doe's.jpg", user_id: admin.id, details: 'wonderfull' } }
  let(:auth_headers) { sign_in(admin) }

  path '/hotels' do
    post 'Creates a new hotel' do
      before do
        headers = auth_headers
      end
      parameter name: :hotel, in: :body, schema: {
        type: :object,
        properties: {
          hotel: {
            type: :object,
            properties: {
              name: { type: :string },
              city: { type: :string },
              country: { type: :string },
              phone: { type: :string },
              image: { type: :string },
              user_id: { type: :integer },
              details: { type: :string },
            },
            required: [ 'name', 'city', 'country', 'phone', 'image', 'user_id', 'details' ]
          }
        }
      }

      response '201', 'hotel created' do
        let(:hotel) { valid_attributes }
        run_test! do
          expect(response.body).to include_json(hotel.to_json)
        end
      end

      response '422', 'invalid request' do
        let(:hotel) { invalid_attributes }
        run_test!
      end
    end
  end
end

