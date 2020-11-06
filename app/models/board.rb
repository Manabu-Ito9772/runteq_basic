class Board < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
end
