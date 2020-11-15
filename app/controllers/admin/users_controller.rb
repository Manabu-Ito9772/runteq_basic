class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @search = User.ransack(params[:q])
    @users = @search.result(distinct: true).page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, success: t('.success')
    else
      flash.now[:danger] = t('.danger')
      render :edit
    end
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_path, success: t('.success')
  end

  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
