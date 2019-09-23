class Posts::RepostsController < ApplicationController
  def new
    @parent_post = Post.find(params[:post_id])
    @post = Post.new
  end

  def create
    @parent_post = Post.find(params[:post_id])
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

  def repost_params
    params.require(:post).permit(:content, :image)
  end
end
