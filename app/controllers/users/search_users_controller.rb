class Users::SearchUsersController < ApplicationController
  def index
    @users =
      if params[:name].empty?
        User.all
      else
        unless params[:search_method] === 'exclude'
          params_name = Search.condition(params[:search_method], params[:name])
          User.match(params_name)
        else
          User.exclude(params[:name])
        end
      end
    render 'users/index'
  end
end
