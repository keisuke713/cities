require 'rails_helper'

RSpec.describe FollowingsController, type: :controller do

  describe "GET #index" do
    let(:relationship) {
      FactoryBot.create(:relationship)
    }
    let(:user) {
      relationship.follower
    }
    let(:following_user) {
      relationship.followed
    }
    let(:user_params) {
      { id: user.id }
    }
    before do
      log_in user
    end
    it "return http success" do
      get :index, params: user_params
      expect(response.status).to eq 200
    end

    it "assign following user" do
      get :index, params: user_params
      expect(assigns(:users)).to include(following_user)
    end

    it "render index page" do
      get :index, params: user_params
      expect(response).to render_template 'index'
    end
  end

end
