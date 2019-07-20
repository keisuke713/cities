class SessionsController < ApplicationController
  before_action :store_location, only: :new

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email])

    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      flash[:success] = success_login_msg
      redirect_to session[:previous_url]
    else
      flash[:danger] = failure_login_msg
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = success_log_out_msg
    redirect_to root_url
  end
end
