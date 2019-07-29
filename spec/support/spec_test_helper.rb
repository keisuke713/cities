module SpecTestHelper
  def log_in(user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    session[:user_id] = user.id
    visit root_path
  end
end
