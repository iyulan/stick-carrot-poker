class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_and_redirect
    else
      flash[:danger] = 'Oops!'
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

  def login_and_redirect
    login(params[:user][:email], params[:user][:password])
    flash[:success] = "Welcome, #{@user.name}!"
    redirect_to authenticated_root_path
  end
end
