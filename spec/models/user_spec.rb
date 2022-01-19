require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user1 = User.new(
      name: 'Guilherme',
      age: 25,
      location: 'Brazil',
      email: 'test@gmail.com',
      password: '123456',
      user_type: 'admin'
    )
    @user2 = User.new(
      name: 'zézinho',
      age: 25,
      location: 'Brazil',
      email: 'test@gmail.com',
      password: '123456',
      user_type: 'admin'
    )
  end  

  it 'Expects user1 to be created correctly' do  
    @user1.save  
    expect(@user1).to be_valid
  end

  it 'Expects to be invalid if email is not present' do
    @user1.email = nil
    @user1.save
    expect(@user1.errors.full_messages).to eq(["Email can't be blank", "Email is too short (minimum is 9 characters)"])    
  end

  it 'Expects to be invalid if name is not present' do
    @user1.name = nil
    @user1.save
    expect(@user1.errors.full_messages).to eq(["Name can't be blank", "Name is too short (minimum is 6 characters)"])    
  end

  it 'Expects to be invalid if age is not present' do
    @user1.age = nil
    @user1.save
    expect(@user1.errors.full_messages).to eq(["Age can't be blank", "Age is not a number"])    
  end

  it 'Expects to be invalid if password is not present' do
    @user1.password = nil
    @user1.save
    expect(@user1.errors.full_messages).to eq(["Password can't be blank", "Password is too short (minimum is 4 characters)"])    
  end

  it 'Expects to be invalid if user_type is not present' do
    @user1.user_type = nil
    @user1.save
    expect(@user1.errors.full_messages).to eq(["User type can't be blank", "User type is too short (minimum is 4 characters)"])    
  end

  it 'Expects to be invalid if location is not present' do
    @user1.location = nil
    @user1.save
    expect(@user1.errors.full_messages).to eq(["Location can't be blank"])    
  end

  it 'Expects email to be unique' do 
    @user1.save
    @user2.save   
    expect(@user2.errors.full_messages).to eq(["Email has already been taken"])
  end

  it 'Expects password to be invalid' do 
    @user2.password = '12'
    @user2.save
    expect(@user2.errors.full_messages).to eq(["Password is too short (minimum is 4 characters)"]) 
  end

  it 'Expects name to be invalid because of length' do
    @user2.name = 'zé'
    @user2.save
    expect(@user2.errors.full_messages).to eq(["Name is too short (minimum is 6 characters)"]) 
  end
end
