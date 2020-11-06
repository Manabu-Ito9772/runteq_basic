class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :board
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :user_id, presence: true
  validates :board_id, presence: true
end
