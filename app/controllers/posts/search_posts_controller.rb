class Posts::SearchPostsController < ApplicationController
  def index
    @posts = fetch_posts(params[:keyword], params[:search_method])
    render 'posts/index'
  end

  private

  def fetch_posts(keyword, search_method)
    if keyword.empty?
      fetch_all_posts
    else
      fetch_postss_by(keyword, search_method)
    end
  end

  def fetch_all_posts
    Post.all.includes(:user)
  end

  def fetch_postss_by(keyword, search_method)
    if search_method == 'user_match'
      fetch_posts_by_user_name(keyword)
    else
      fetch_posts_by_content(keyword, search_method)
    end
  end

  def fetch_posts_by_user_name(keyword)
    user_ids = User.match(keyword).pluck(:id)
    Post.user_match(user_ids).includes(:user)
  end

  def fetch_posts_by_content(keyword, search_method)
    keyword = Search.condition(search_method, keyword)
    Post.content_match(keyword).includes(:user)
  end
end
