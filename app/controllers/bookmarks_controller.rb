class BookmarksController < ApplicationController
  before_action :require_login

  def create
    current_user.bookmarks.create(board_id: params[:board_id])
    flash[:success] = t('.success')
    redirect_to request.referrer
  end

  def destroy
    current_user.bookmarks.find_by(board_id: params[:id]).destroy
    flash[:success] = t('.success')
    redirect_to request.referrer
  end
end
