class Posts::SearchPostsController < ApplicationController
  def index
    @posts =
      if params[:keyword].empty?
        Post.all
      else
        if params[:search_method] == 'user_match'
          user_ids = User.match(params[:keyword]).pluck(:id)
          Post.user_match(user_ids).includes(:user)
        else
          Post.content_match("%#{params[:keyword]}%").includes(:user)
        end
      end
    render 'posts/index'
  end
end
