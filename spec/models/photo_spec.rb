require 'rails_helper'

RSpec.describe Photo, type: :model do
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
      user_id: @user.id,
      link: 'urltophoto',
      photo_type: 'lol'
    )
  end

  it 'Expects photo to be created correctly' do
    expect(@photo).to be_valid
  end

  it 'Expects photo to be invalid due to length of photo_type' do
    @photo.photo_type = 'lolololo'
    expect(@photo).to be_invalid
  end
end
