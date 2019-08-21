class RepliesController < ApplicationController
  def new
    @comment = Comment.find(params[:comment_id])
    @reply = Reply.new
  end

  def create
  end
end
