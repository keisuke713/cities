class SessionsController < ApplicationController
  before_action :store_location, only: :new
  skip_before_action :logged_in_user

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email])

    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      flash[:success] = 'Success log in!'
      redirect_to session[:previous_url]
    else
      flash[:danger] = 'Not correct email or password'
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = 'Success log out!'
    redirect_to root_url
  end
end
