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
    @video = Video.create(
      link: 'www.youtube.com',
      user_id: @user.id,
      video_type: 'lol'
    )
  end

  path '/api/video/create' do
    post 'User creates video' do
      tags 'Video'
      consumes 'application/json'
      parameter name: :video, in: :body, schema: {
        type: :object,
        properties: {
          link: { type: :string },
          user_id: { type: :integer },
          video_type: { type: :string }
        },
        required: %w[user_id link video_type]
      }

      response '200', 'User created a video' do
        let(:video) do
          {
            user_id: @user.id,
            link: 'www.youtube.com',
            video_type: 'COD'
          }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:video) { { user_id: @user.id } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).to eq([
            "Link can't be blank", 
            "Video type can't be blank", 
            "Video type is too short (minimum is 2 characters)"
          ])
        end
      end
    end
  end

  path '/api/video/delete' do
    delete 'User deletes video' do
      tags 'Favorite_gamer'
      consumes 'application/json'
      parameter name: :video, in: :body, schema: {
        type: :object,
        properties: {
          id: { type: :integer },
        },
        required: %w[id]
      }

      response '200', 'User deletes video' do
        let(:video) { {id: @video.id} }
        run_test!
      end

      response '422', 'invalid request' do
        let(:video) { {} }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).to eq('Please provide a proper id')
        end
      end
    end
  end
end
