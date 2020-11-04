class BoardsController < ApplicationController
  before_action :require_login

  def index
    @boards = Board.all
  end

  private

  def not_authenticated
    redirect_to login_path, danger: 'ログインしてください'
  end
end
