require 'rails_helper'

RSpec.describe 'Photos', type: :request do
  before(:each) do
    @user = User.create(
      name: 'Guilherme',
      age: 25,
      location: 'Brazil',
      email: 'guilherme@gmail.com',
      password: '123456',
      user_type: 'admin'
    )
    @photo = Photo.create(
      link: 'www.imgur.com',
      user_id: @user.id,
      photo_type: 'lol'
    )
  end

  path '/api/photo/create' do
    post 'User creates photo' do
      tags 'Photo'
      consumes 'application/json'
      parameter name: :photo, in: :body, schema: {
        type: :object,
        properties: {
          link: { type: :string },
          user_id: { type: :integer },
          photo_type: { type: :string }
        },
        required: %w[user_id link photo_type]
      }

      response '200', 'User created a photo' do
        let(:photo) do
          {
            user_id: @user.id,
            link: 'www.youtube.com',
            photo_type: 'COD'
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:photo) { { user_id: @user.id } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).to eq([
                                        "Link can't be blank",
                                        "Photo type can't be blank",
                                        'Photo type is too short (minimum is 2 characters)'
                                      ])
        end
      end
    end
  end

  path '/api/photo/delete' do
    delete 'User deletes photo' do
      tags 'Photo'
      consumes 'application/json'
      parameter name: :photo, in: :body, schema: {
        type: :object,
        properties: {
          id: { type: :integer }
        },
        required: %w[id]
      }

      response '200', 'User deletes photo' do
        let(:photo) { { id: @photo.id } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:photo) { {} }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).to eq('Please provide a proper id')
        end
      end
    end
  end
end
