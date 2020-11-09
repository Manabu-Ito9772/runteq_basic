class BookmarksController < ApplicationController
  before_action :require_login

  def create
    @board = Board.find(params[:board_id])
    current_user.bookmark(@board)
  end

  def destroy
    @board = Bookmark.find(params[:id]).board
    current_user.unbookmark(@board)
  end
end
