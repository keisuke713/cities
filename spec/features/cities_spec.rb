require 'rails_helper'

RSpec.feature "Cities", type: :feature do
  scenario 'User is logged in and post' do
    pending "can't login by any means"
    given!(:user) {
      FactoryBot.create(:user)
    }

    background do
      visit user_path(id: 1)
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_on "Log in"
      session[:user_id] = user.id
    end

    it "post" do
      visit new_user_post_path(user.id)
    end
  end
end
