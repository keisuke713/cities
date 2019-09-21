class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post

    if @comment.save
      flash[:success] = 'success in commenting'
      redirect_to post_url(params[:post_id])
    else
      render 'new'
    end
  end

  def show
    @comment = Comment.find(params[:id])
    @replies = @comment.replies.includes(:user)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
