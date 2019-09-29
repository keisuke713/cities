class Posts::SearchPostsController < ApplicationController
  def index
    @posts =
      if params[:keyword].empty?
        Post.all
      else
      end
    render 'posts/index'
  end
end
