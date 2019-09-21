class BookMarksController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.book_marked_posts
  end

  def create
    @post = Post.find(params[:post_id])
    book_mark = @post.book_marks.build(user_id: current_user.id)

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
