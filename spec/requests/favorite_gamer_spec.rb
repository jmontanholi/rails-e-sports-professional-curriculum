require 'rails_helper'

RSpec.describe 'FavoriteGamers', type: :request do
  before(:each) do
    @company = Company.create(
      name: 'Company',
      location: 'Brazil',
      email: 'test@gmail.com',
      password: '123456'
    )
    @user = User.create(
      name: 'Guilherme',
      age: 25,
      location: 'Brazil',
      email: 'guilherme@gmail.com',
      password: '123456',
      user_type: 'admin'
    )
    @favorite_gamer = FavoriteGamer.create(
      user_id: @user.id,
      company_id: @company.id
    )
  end

  path '/api/favorite/create' do
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

  path '/api/favorite/delete' do
    delete 'Company unfavorites a gamer' do
      tags 'Favorite_gamer'
      consumes 'application/json'
      parameter name: :favorite_gamer, in: :body, schema: {
        type: :object,
        properties: {
          id: { type: :integer }
        },
        required: %w[id]
      }

      response '200', 'company unfavorited a gamer' do
        let(:favorite_gamer) { { id: @favorite_gamer.id } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:favorite_gamer) { {} }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).to eq('Please provide the proper params: id: integer')
        end
      end
    end
  end
end
