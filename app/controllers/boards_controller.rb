class BoardsController < ApplicationController
  before_action :require_login
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @search = Board.ransack(params[:q])
    @boards = @search.result(distinct: true).includes(:user, :bookmarks).order(created_at: :desc).page(params[:page])
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.all.includes(:user).order(created_at: :desc)
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

  def edit; end

  def update
    if @board.update(board_params)
      redirect_to board_path(@board), success: t('.success')
    else
      flash.now[:danger] = t('.danger')
      render :edit
    end
  end

  def destroy
    @board.destroy
    redirect_to boards_path, success: t('.success')
  end

  def bookmarks
    @search = current_user.favorite_boards.ransack(params[:q])
    @boards = @search.result(distinct: true).includes(:user, :bookmarks).order(created_at: :desc).page(params[:page])
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :image, :image_cache)
  end

  def correct_user
    @board = current_user.boards.find(params[:id])
  end
end
