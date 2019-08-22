class RepliesController < ApplicationController
  def new
    @comment = Comment.find(params[:comment_id])
    @reply = Reply.new
  end

  def create
    @comment = Comment.find(params[:comment_id])
    @reply = current_user.replies.build(reply_params)
    @reply.comment = @comment
    
    if @reply.save
      flash[:success] = 'success in replying'
      redirect_to comment_url(params[:comment_id])
    else
      render 'new'
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:content)
  end
end
