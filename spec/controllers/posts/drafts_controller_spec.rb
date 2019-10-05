require 'rails_helper'

RSpec.describe Posts::DraftsController, type: :controller do
  let(:user) {
    FactoryBot.create(:user)
  }
  before do
    log_in user
  end

  describe "GET #index" do
    let!(:post) {
      FactoryBot.create(:post)
    }
    let!(:draft) {
      FactoryBot.create(:draft)
    }
    let(:params) {
      { user_id: user.id }
    }
    it "returns http success" do
      get :index, params: params
      expect(response.status).to eq 200
    end

    it "assigns drafts" do
      get :index, params: params
      expect(assigns(:drafts)).to contain_exactly draft
    end

    it "render index page" do
      get :index, params: params
      expect(response).to render_template 'index'
    end
  end
end
