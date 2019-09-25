class Posts::RepostsController < ApplicationController
  before_action :find_parent_post

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(repost_params).tap do |post|
      post.parent_post = @parent_post
    end

    if @post.save
      flash[:success] = 'success in reposting'
      redirect_to current_user
    else
      render 'new'
    end
  end

  private

  def find_parent_post
    @parent_post = Post.find(params[:post_id])
  end

  def repost_params
    params.require(:post).permit(:content, :image)
  end
end
