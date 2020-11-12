class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: t('.success')
    else
      flash.now[:danger] = t('.danger')
      render :new
    end
  end

  def update
    user = User.find_by(id: current_user.id)
    if user.update(user_edit_params)
      redirect_to profile_path, success: t('.success')
    else
      flash.now[:danger] = t('.danger')
      render 'profiles/edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:last_name,
                                 :first_name,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end

  def user_edit_params
    params.require(:user).permit(:email, :last_name, :first_name, :avatar)
  end
end
