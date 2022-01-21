require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Companies', type: :request do
  before(:all) do
    @company = Company.create(
      name: 'Google',
      email: 'google@gmail.com',
      password: '123456aA',
      location: 'Coimbra'
    )
  end

  path '/api/companies/sign_in' do
    post 'Company logs in' do
      tags 'Company'
      consumes 'application/json'
      parameter name: :company, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '200', 'company logged in' do
        let(:company) do
          {
            email: 'google@gmail.com',
            password: '123456aA'
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to eq({
                               'company' => {
                                 'email' => 'google@gmail.com',
                                 'favorite_gamers' => [],
                                 'location' => 'Coimbra',
                                 'name' => 'Google'
                               }
                             })
        end
      end

      response '404', 'invalid request' do
        let(:company) { { email: 'google@hotmail.com', password: '123456aA' } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).to eq('No user was found with that email')
        end
      end
    end
  end

  path '/api/companies/sign_up' do
    post 'Creates a new company' do
      tags 'Company'
      consumes 'application/json'
      parameter name: :company, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          name: { type: :string },
          location: { type: :string }
        },
        required: %w[email password name location]
      }

      response '200', 'company logged in' do
        let(:company) do
          {
            email: 'razer@gmail.com',
            password: '123456aA',
            name: 'razer',
            location: 'silicon valley'
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to eq({ 'company' => { 'email' => 'razer@gmail.com', 'favorite_gamers' => [],
                                              'location' => 'silicon valley', 'name' => 'razer' } })
        end
      end

      response '422', 'invalid request' do
        let(:company) do
          {
            email: '',
            password: '',
            name: '',
            location: ''
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['errors']).to eq(["Name can't be blank",
                                        "Email can't be blank",
                                        "Password can't be blank",
                                        "Location can't be blank",
                                        'Name is too short (minimum is 5 characters)',
                                        'Email is too short (minimum is 9 characters)',
                                        'Password is too short (minimum is 4 characters)'])
        end
      end
    end
  end

  path '/api/companies/delete' do
    delete 'Delete a company' do
      tags 'Company'
      consumes 'application/json'
      parameter name: :company, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '200', 'company logged in' do
        let(:company) do
          {
            email: 'google@gmail.com',
            password: '123456aA'
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to eq({ 'success' => 'The company was successfully deleted' })
        end
      end

      response '422', 'invalid request' do
        let(:company) { { email: 'google@gmail.com', password: '123456' } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).to eq('The email or the password is wrong')
        end
      end

      response '404', 'invalid request' do
        let(:company) { { email: 'google@hotmail.com', password: '123456aA' } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).to eq('No company was found with that email')
        end
      end
    end
  end
end
