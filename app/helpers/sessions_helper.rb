module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    current_user == user
  end

  def log_out
    session.delete(:user_id)
  end

  def store_location
    session[:previous_url] = session[:current_url] || request.referer
    location_destroy
  end

  def current_store_location
    session[:current_url] = request.fullpath
  end

  def location_destroy
    session.delete(:current_url)
  end
end
