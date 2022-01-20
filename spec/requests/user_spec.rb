require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Users', type: :request do
  before(:all) do
  @user = User.create(
    name: 'Guilherme',
    age: 25,
    location: 'Brazil',
    email: 'test@gmail.com',
    password: '123456',
    user_type: 'admin'
  )
  end

  path '/api/users/sign_in' do 
    post 'User logs in' do
      tags 'User'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '200', 'user logged in' do        
          let(:user) do
            {
              email: 'test@gmail.com',
              password: '123456'
            }
          end 
          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data).to eq({
              'user' => {
                'name' => 'Guilherme',
                'description' => nil,
                'age' => 25,
                'location' => 'Brazil',
                'email' => 'test@gmail.com',   
                "photos" => [],
                "videos" => []
              }
            })
          end        
      end 
      
      response '404', 'invalid request' do
        let(:user) { { email: 'google@hotmail.com', password: '123456'}  }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).to eq('No user was found with that email')
        end
      end
    end
  end

  path '/api/users/sign_up' do
    post 'Creates a new user' do
      tags 'User'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          name: { type: :string },
          location: { type: :string },
          user_type: { type: :string },
          age: { type: :integer }
        },
        required: %w[email password name location user_type age]
      }

      response '200', 'user sign up' do
        let(:user) do
          {
            email: 'test2@gmail.com',
            password: '123456',
            name: 'Guilherme',
            location: 'Brazil',
            user_type: 'admin',
            age: 25
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to eq({ 'user' => {
            'name' => 'Guilherme',
            'description' => nil,
            'age' => 25,
            'location' => 'Brazil',
            'email' => 'test2@gmail.com',   
            "photos" => [],
            "videos" => []
          } 
        })
        end
      end

      response '422', 'invalid request' do
        let(:user) do
          {
            email: '',
            password: '',
            name: '',
            location: '',
            user_type: '',
            age: ''
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['errors']).to eq(["Name can't be blank",
                                        "Age can't be blank",
                                        "Location can't be blank",
                                        "Email can't be blank",
                                        "Password can't be blank",
                                        "User type can't be blank",
                                        "Name is too short (minimum is 6 characters)",
                                        "Age is not a number",
                                        "Email is too short (minimum is 9 characters)",
                                        "Password is too short (minimum is 4 characters)",
                                        "User type is too short (minimum is 4 characters)"])
        end
    end  
  end

  path '/api/users/delete' do
    delete 'Delete a user' do
      tags 'User'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '200', 'user logged in' do
        let(:user) do
          {
            email: 'test@gmail.com',
            password: '123456'
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to eq({ 'success' => 'The user was successfully deleted' })
        end
      end

      response '422', 'invalid request' do
        let(:user) { { email: 'test@gmail.com', password: '1234526' } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).to eq('The email or the password is wrong')
        end
      end

      response '404', 'invalid request' do
        let(:user) { { email: 'google@hotmail.com', password: '123456' } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).to eq('No user was found with that email')
        end
      end
    end
  end
end
end

