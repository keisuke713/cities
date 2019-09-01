class BookMarksController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.find(params[:user_id])
    @posts = @user.book_marked_posts
  end

  def create
    @post = Post.find(params[:post_id])
    book_mark = BookMark.new(
      user_id: current_user.id,
      post_id: params[:post_id]
    )

    if book_mark.save
      redirect_to @post
    else
      render 'posts/show'
    end
  end

  def destroy
    BookMark.find(params[:id]).destroy
    redirect_to post_url(params[:post_id])
  end
end
