module ApplicationHelper
  def header_link
    render (
    logged_in? ? 'shared/when_login_link' : 'shared/when_not_login_link'
    )
  end

  def signup_link
    render 'shared/signup_link' unless logged_in?
  end

  def flash_msg
    render 'shared/flash'
  end
end
