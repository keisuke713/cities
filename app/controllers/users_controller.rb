class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user?, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome to The Cities!!!!"
      log_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = user
    @posts = @user.posts
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(user_params)
      flash[:success] = "Update Profile!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user.destroy
    flash[:success] = 'success!'
    redirect_to users_path
  end

  def following
    @users = user.following.paginate(page: params[:page])
    render 'index'
  end

  def followers
    @users = user.followers.paginate(page: params[:page])
    render 'index'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :intro, :image, :password, :password_confirmation)
  end

  def correct_user
    unless current_user?
      flash[:danger] = "You can't  edit"
      redirect_to root_path
    end
  end

  def current_user?
    current_user == user
  end

  def admin_user?
    redirect_to root_path unless current_user.admin?
  end
end
