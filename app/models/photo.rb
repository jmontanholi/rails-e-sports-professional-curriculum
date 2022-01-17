class Photo < ApplicationRecord
  belongs_to :user

  validates :user_id, :link, :photo_type, presence: true
  validates :photo_type, length: { in: 2..5}
end
