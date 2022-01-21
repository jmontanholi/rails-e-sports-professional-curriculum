# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = [
  {
    name: 'João Vítor Montanholi Nunes',
    age: 21,
    location: 'São Paulo, Brazil',
    email: 'jonunes9326@hotmail.com.br',
    password: '123456aA',
    description: 'I am a pro gamer',
    user_type: 'Admin'
  },
  {
    name: 'Jaqueline guilherme',
    age: 27,
    location: 'São Paulo, Brazil',
    email: 'jaqueline@gmail.com',
    password: '123456aA',
    description: 'I am a pro gamer',
    user_type: 'gamer'
  },
  {
    name: 'Pedrinho do ff',
    age: 15,
    location: 'Rio de Janeiro',
    email: 'pedrinho@gmail.com',
    password: '123456aA',
    description: 'I am a pro gamer',
    user_type: 'gamer'
  },
  {
    name: 'Guilherme Giachellin',
    age: 23,
    location: 'Anta gorda, sul do Brasil',
    email: 'guilhermeG@hotmail.com.br',
    password: '123456aA',
    description: 'I am a pro gamer',
    user_type: 'Admin'
  },
]

User.create(users)

companies = [
  {
    name: 'Google',
    email: 'google@gmail.com',
    location: 'Silicon valley',
    password: '123456aA'
  },
  {
    name: 'Youtube',
    email: 'youtube@gmail.com',
    location: 'Silicon valley',
    password: '123456aA'
  },
  {
    name: 'Imgur',
    email: 'imgur@gmail.com',
    location: 'Silicon valley',
    password: '123456aA'
  },
]

Company.create(companies)

videos = [
  {
    link: 'www.youtube.com',
    user_id: '1',
    video_type: 'COD'
  },
  {
    link: 'www.youtube.com',
    user_id: '2',
    video_type: 'LOL'
  },
  {
    link: 'www.youtube.com',
    user_id: '3',
    video_type: 'OW'
  },
  {
    link: 'www.youtube.com',
    user_id: '4',
    video_type: 'DOTA'
  }
]

Video.create(videos)

photos = [
  {
    link: 'www.imgur.com',
    user_id: '1',
    photo_type: 'COD'
  },
  {
    link: 'www.imgur.com',
    user_id: '2',
    photo_type: 'LOL'
  },
  {
    link: 'www.imgur.com',
    user_id: '3',
    photo_type: 'OW'
  },
  {
    link: 'www.imgur.com',
    user_id: '4',
    photo_type: 'DOTA'
  }
]

Photo.create(photos)

favorite_gamers = [
  {
    user_id: 1,
    company_id: 1
  },
  {
    user_id: 2,
    company_id: 1
  },
  {
    user_id: 2,
    company_id: 2
  },
  {
    user_id: 3,
    company_id: 2
  },
  {
    user_id: 1,
    company_id: 3
  },
  {
    user_id: 4,
    company_id: 3
  },
]

FavoriteGamer.create(favorite_gamers)