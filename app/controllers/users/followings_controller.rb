class Users::FollowingsController < ApplicationController
  def index
    @users = User.find(params[:user_id]).following
  end
end
