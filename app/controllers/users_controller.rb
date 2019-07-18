class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome to The Cities!!!!"
      session[:user_id] = @user.id
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :age, :password, :password_confirmation)
  end
end
