class Users::FollowingsController < ApplicationController
  def index
    @users = User.find(params[:user_id]).followings
  end
end
