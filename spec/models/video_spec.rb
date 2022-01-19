require 'rails_helper'

RSpec.describe Video, type: :model do
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
      user_id: @user.id,
      link: 'urltovideo',
      video_type: 'lol'
    )
  end

  it 'Expects video to be created correctly' do    
    expect(@video).to be_valid
  end

  it 'Expects video to be invalid due to length of video_type' do  
    @video.video_type = 'lolololo'  
    expect(@video).to be_invalid
  end
end
