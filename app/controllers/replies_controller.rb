class RepliesController < ApplicationController
  before_action :logged_in_user

  def new
    @comment = Comment.find(params[:comment_id])
    @reply = Reply.new
  end

  def create
    @comment = Comment.find(params[:comment_id])
    @reply = current_user.replies.build(reply_params) do |reply|
      reply.comment = @comment
    end

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
