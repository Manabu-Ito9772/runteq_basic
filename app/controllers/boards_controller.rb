class BoardsController < ApplicationController
  before_action :require_login

  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_url, success: t('.success')
    else
      flash.now[:danger] = t('.danger')
      render :new
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :image)
  end
end
