class User < ApplicationRecord
  before_save :email_downcase
  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :favorite_boards, through: :bookmarks, source: :board
  mount_uploader :avatar, AvatarUploader
  authenticates_with_sorcery!

  validates :last_name, presence: true, length: { maximum: 255 }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  def email_downcase
    self.email = email.downcase
  end

  def own?(object)
    id == object.user_id
  end

  def bookmark(board)
    favorite_boards << board
  end

  def unbookmark(board)
    bookmarks.find_by(board_id: board.id).destroy
  end

  def bookmark?(board)
    favorite_boards.include?(board)
  end
end
