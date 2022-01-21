require 'rails_helper'

RSpec.describe Company, type: :model do
  before(:each) do
    @company1 = Company.new(
      name: 'Company',
      location: 'Brazil',
      email: 'test@gmail.com',
      password: '123456'
    )
    @company2 = Company.new(
      name: 'Company',
      location: 'Brazil',
      email: 'test@gmail.com',
      password: '123456'
    )
  end

  it 'Expects company1 to be created correctly' do
    @company1.save
    expect(@company1).to be_valid
  end

  it 'Expects to be invalid if email is not present' do
    @company1.email = nil
    @company1.save
    expect(@company1.errors.full_messages).to eq(["Email can't be blank",
                                                  'Email is too short (minimum is 9 characters)'])
  end

  it 'Expects to be invalid if password is not present' do
    @company1.password = nil
    @company1.save
    expect(@company1.errors.full_messages).to eq(["Password can't be blank",
                                                  'Password is too short (minimum is 4 characters)'])
  end

  it 'Expects to be invalid if location is not present' do
    @company1.location = nil
    @company1.save
    expect(@company1.errors.full_messages).to eq(["Location can't be blank"])
  end

  it 'Expects email to be unique' do
    @company1.save
    @company2.save
    expect(@company2.errors.full_messages).to eq(['Email has already been taken'])
  end

  it 'Expects password to be invalid' do
    @company2.password = '12'
    @company2.save
    expect(@company2.errors.full_messages).to eq(['Password is too short (minimum is 4 characters)'])
  end

  it 'Expects name to be invalid because of length' do
    @company2.name = 'zé'
    @company2.save
    expect(@company2.errors.full_messages).to eq(['Name is too short (minimum is 5 characters)'])
  end
end
