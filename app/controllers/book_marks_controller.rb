class BookMarksController < ApplicationController
  def index
  end

  def create
    BookMark.create(user_id: current_user.id, post_id: params[:post_id])
    redirect_to post_url(params[:post_id])
  end

  def destroy
  end
end
