class User < ApplicationRecord
    has_many :photos, dependent: :destroy
    has_many :videos, dependent: :destroy
    has_many :favorite_gamers
    has_many :companies, through: :favorite_gamers

    validates :name, 
              :age, 
              :location, 
              :email, 
              :password, 
              :user_type, 
              presence: true
    validates :name, length: {in: 6..40}
    validates :age, numericality: { only_integer: true }
    validates :email, length: {in: 13..30}
    validates :password, length: {in: 4..12}
    validates :user_type, length: {in: 4..10}
end
