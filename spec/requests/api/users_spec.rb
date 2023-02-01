require 'swagger_helper'

RSpec.describe 'Users', type: :request do
  path '/api/v1/auth/signup' do
    post 'Add new user' do
      tags 'Users'
      description "Add new user. one parameter can be added in a direct request to the api this could contain 'role'
			 and this is the way to add admin."
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: { name: { type: :string }, username: { type: :string }, email: { type: :string },
                      password: { type: :string } },
        required: %w[name username email password]
      }

      response '201', 'success' do
        run_test!

        let(:user) do
          { name: 'user', email: 'user@example.com', password: 'password', username: 'user' }
        end
      end

      response '422', 'email or password cannot be blank' do
        let(:headers) { invalid_parameters }
        run_test!
      end

      response '422', 'password cannot be blank' do
        let(:body) { invalid_parameters }
        run_test!
      end
      response '400', 'bad request, you are already registered' do
        let(:body) { invalid_parameters }
        run_test!
      end
    end
  end
  path '/api/v1/auth/login' do
    post 'login' do
      tags 'Users'
      description "Log user in. This request will return such object:
						{
							'token': <token_string>,
							'user': { 'username': <username_string>, 'role': 'role_string' }
						}.
						"
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: { email: { type: :string }, password: { type: :string } },
        required: %w[email password]
      }

      response '201', 'success' do
        run_test!

        let(:user) do
          { name: 'user', email: 'user@example.com', password: 'password' }
        end
      end

      response '422', 'email cannot be blank' do
        let(:body) { invalid_parameters }
        run_test!
      end
      response '400', 'bad request wrong password or email' do
        let(:body) { invalid_parameters }
        run_test!
      end
    end
  end
end
