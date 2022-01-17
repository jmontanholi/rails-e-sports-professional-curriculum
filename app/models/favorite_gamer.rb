class FavoriteGamer < ApplicationRecord
  belongs_to :company
  belongs_to :user

  validates :user_id, :company_id, presence: true
end
