class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
  　if comment.save
     redirect_to board_path(comment.board.id), success: t('.success')
   elsif
     redirect_to board_path(comment.board.id), danger: t('.danger')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end
end
