class RepliesController < ApplicationController
  def new
    @comment = Comment.find(params[:id])
    @reply = Reply.new
  end

  def create
  end
end
