class Company < ApplicationRecord
  has_many :favorite_gamers
  has_many :users, through: :favorite_gamers

  validates :email, uniqueness: true
  validates :name, :email, :password, :location, presence: true
  validates :name, length: { in: 5..40 }
  validates :email, length: { in: 9..30 }
  validates :password, length: { in: 4..12 }
end
