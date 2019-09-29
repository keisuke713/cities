class Posts::SearchPostsController < ApplicationController
  def index
    @posts =
      if params[:keyword].empty?
        Post.all
      else
        if params[:search_method] == 'user_match'
          user_ids = User.where('name = ?', params[:keyword]).pluck(:id)
          Post.where("user_id = ?", user_ids)
        else
          Post.where("content like ?", "%#{params[:keyword]}%")
        end
      end
    render 'posts/index'
  end
end
