class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find(params[:user_id])

    relationship = current_user.active_relationships.build(followed_id: @user.id)
    if relationship.save
      flash[:success] = 'success in following'
      redirect_to user_url(@user)
    else
      flash[:danger] = 'unsuccess in following'
      render 'users/show'
    end
  end

  def destroy
    Relationship.find(params[:id]).destroy
    flash[:success] = 'success in unfollowing'
    redirect_to user_url(params[:user_id])
  end
end
