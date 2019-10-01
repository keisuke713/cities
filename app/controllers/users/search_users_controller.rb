class Users::SearchUsersController < ApplicationController
  def index
    @users = fetch_users(params[:search_method], params[:name])
    render 'users/index'
  end

  private

  def fetch_users(search_method, name)
    if name.empty?
      fetch_all_users
    else
      fetch_users_by(search_method, name)
    end
  end

  def fetch_all_users
    User.all
  end

  def fetch_users_by(search_method, name)
    unless search_method === 'exclude'
      fetch_users_by_user_name(search_method, name)
    else
      fetch_users_by_excluding(name)
    end
  end

  def fetch_users_by_user_name(search_method, name)
    search_condition = Search.condition(search_method, name)
    User.match(search_condition)
  end

  def fetch_users_by_excluding(name)
    User.exclude(name)
  end
end
