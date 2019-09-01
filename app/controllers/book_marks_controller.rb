class BookMarksController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(id: BookMark.post_id(params[:user_id]))
  end

  def create
    current_user.book_marks.create(post_id: params[:post_id])
    redirect_to post_url(params[:post_id])
  end

  def destroy
  end
end
