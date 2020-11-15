class Admin::BoardsController < Admin::BaseController
  before_action :set_board, only: %i[show edit update destroy]

  def index
    @search = Board.ransack(params[:q])
    @boards = @search.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @board.update(board_params)
      redirect_to admin_board_path(@board), success: t('.success')
    else
      flash.now[:danger] = t('.danger')
      render :edit
    end
  end

  def destroy
    @board.destroy!
    redirect_to admin_boards_path, success: t('.success')
  end

  def board_params
    params.require(:board).permit(:title, :body, :image)
  end

  def set_board
    @board = Board.find(params[:id])
  end
end
