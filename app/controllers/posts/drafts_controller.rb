class Posts::DraftsController < ApplicationController
  def index
    @drafts = Post.fetch_only_draft(params[:user_id])
  end

  def edit
    @draft = Post.find(params[:id])
  end

  def update
  end
end
