require 'rails_helper'

RSpec.describe Users::FollowersController, type: :controller do

  describe "GET #index" do
    let(:relationship) {
      FactoryBot.create(:relationship)
    }
    let(:user) {
      relationship.followed
    }
    let(:following_user) {
      relationship.follower
    }
    let(:user_params) {
      { user_id: user.id }
    }
    before do
      log_in user
    end
    it "return http success" do
      get :index, params: user_params
      expect(response.status).to eq 200
    end

    it "assign followed user" do
      get :index, params: user_params
      expect(assigns(:users)).to include following_user
    end

    it "render index page" do
      get :index, params: user_params
      expect(response).to render_template 'index'
    end
  end

end
