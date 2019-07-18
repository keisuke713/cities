module SessionsHelper
  def success_login_msg
    'Success log in!'
  end

  def failure_login_msg
    'Not correct email or password'
  end

  def success_log_out_msg
    'Success log out!'
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def log_out
    session.delete(:user_id)
  end

  def store_location
    session[:previous_url] = request.fullpath
  end
end
