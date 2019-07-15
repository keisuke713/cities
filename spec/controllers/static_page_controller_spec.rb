require 'rails_helper'

RSpec.describe StaticPageController, type: :controller do

  describe "GET /" do
    render_views

    it "returns http success" do
      get :home
      expect(response).to have_http_status 200
      assert_select "title", "Cities"
    end
  end

end
