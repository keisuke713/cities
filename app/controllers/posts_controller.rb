class PostsController < ApplicationController
  def index
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

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end
end
