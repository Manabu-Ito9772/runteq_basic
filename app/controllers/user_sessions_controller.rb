class UserSessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to root_url, success: t('.success')
    else
      flash[:danger] = t('.danger')
      render :new
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_url, success: t('.success')
  end
end
