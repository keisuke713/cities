require 'rails_helper'

RSpec.describe StaticPageController, type: :controller do

  describe "GET /" do
    render_views

    it "returns http success" do
      get :home
      expect(response.status).to eq 200
      assert_select "title", "Cities"
      # should have_link 'Sign up', href: '#'
    end
  end
end
