class Company < ApplicationRecord
    has_many :photo, dependent: :destroy
    has_many :video, dependent: :destroy
  
    validates_presence_of :name
end
