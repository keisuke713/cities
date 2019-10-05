class Posts::DraftsController < ApplicationController
  def index
    @drafts = Post.fetch_only_draft(params[:user_id])
  end
end
