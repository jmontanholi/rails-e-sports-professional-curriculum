class Video < ApplicationRecord
  belongs_to :user
  
  validates :link, :video_type, :user_id, presence: true
  validates :video_type, length: { in: 2..5}
end
