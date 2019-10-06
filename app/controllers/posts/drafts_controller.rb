class Posts::DraftsController < ApplicationController
  def index
    @drafts = Post.fetch_only_draft(params[:user_id])
  end

  def edit
    @draft = Post.find(params[:id])
  end

  def update
    @draft = Post.find(params[:id])
    
    if @draft.update_attributes(draft_params)
      redirect_to @draft.user
    else
      render 'edit'
    end
  end

  private

  def draft_params
    params.require(:post).permit(:content, :image, :draft_status)
  end
end
