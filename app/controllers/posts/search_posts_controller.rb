class Posts::SearchPostsController < ApplicationController

  include SearchKeywordConvertable

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
    Post.match_by_user(user_ids).includes(:user)
  end

  def fetch_posts_by_content(keyword, search_method)
    keyword = convert_keyword(search_method, keyword)
    Post.match_by_content(keyword).includes(:user)
  end
end
