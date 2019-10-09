class PostsController < ApplicationController
  def index
    @posts = Post.find_posts(current_user.followings.ids).published
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'succeed in posting'
      redirect_to current_user
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
    @book_mark_id = BookMark.find_by(user_id: current_user.id, post_id: @post.id)&.id
  end

  private

  def post_params
    params.require(:post).permit(:content, :image, :status)
  end
end
