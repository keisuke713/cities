class Posts::DraftsController < ApplicationController
  before_action :fetch_draft, only: [:edit, :update]

  def index
    @drafts = Post.match_by_user(params[:user_id]).draft
  end

  def edit
  end

  def update
    if @draft.update_attributes(draft_params)
      redirect_to @draft.user
    else
      render 'edit'
    end
  end

  private

  def draft_params
    params.require(:post).permit(:content, :image, :status)
  end

  def fetch_draft
    @draft = Post.find(params[:id])
  end
end
