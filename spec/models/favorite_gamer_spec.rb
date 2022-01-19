require 'rails_helper'

RSpec.describe FavoriteGamer, type: :model do
  before(:each) do
    @company = Company.create(
      name: 'Company',      
      location: 'Brazil',
      email: 'test@gmail.com',
      password: '123456',      
    )
    @user = User.create(
      name: 'Guilherme',
      age: 25,
      location: 'Brazil',
      email: 'guilherme@gmail.com',
      password: '123456',
      user_type: 'admin'
    )
    @favorite = FavoriteGamer.create(
      user_id: @user.id,
      company_id: @company.id
    )
  end 

  it 'Expects favorite gamer to be created correctly' do    
    expect(@favorite).to be_valid
  end
end
