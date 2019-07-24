module ApplicationHelper
  def header_link
    render select_header_link
  end

  def select_header_link
    logged_in? ? 'shared/when_login_link' : 'shared/when_not_login_link'
  end

  def signup_link
    render 'shared/signup_link' unless logged_in?
  end

  def flash_msg
    render 'shared/flash'
  end

  def shorted_text(object)
    object.text_slice
  end
end
