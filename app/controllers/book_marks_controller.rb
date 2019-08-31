class BookMarksController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    book_marks = BookMark.where("user_id = ?", params[:user_id])
    post_ids = book_marks.map(&:post_id)
    @posts = Post.where(id: post_ids)
  end

  def create
    BookMark.create(user_id: current_user.id, post_id: params[:post_id])
    redirect_to post_url(params[:post_id])
  end

  def destroy
  end
end
