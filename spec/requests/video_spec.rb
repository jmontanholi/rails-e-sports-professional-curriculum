require 'rails_helper'

RSpec.describe 'Videos', type: :request do
  before(:each) do
    @user = User.create(
      name: 'Guilherme',
      age: 25,
      location: 'Brazil',
      email: 'guilherme@gmail.com',
      password: '123456',
      user_type: 'admin'
    )
  end

  path '/api/video/create' do
    post 'Company favorites a gamer' do
      tags 'Favorite_gamer'
      consumes 'application/json'
      parameter name: :favorite_gamer, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          company_id: { type: :integer }
        },
        required: %w[user_id company_id]
      }

      response '200', 'company favorited a gamer' do
        let(:favorite_gamer) do
          {
            user_id: @user.id,
            company_id: @company.id
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:favorite_gamer) { { user_id: 1 } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).to eq('Please provide the proper params: user_id: integer and company_id: integer')
        end
      end
    end
  end
end
