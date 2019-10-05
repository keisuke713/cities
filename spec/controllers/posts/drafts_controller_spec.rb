require 'rails_helper'

RSpec.describe Posts::DraftsController, type: :controller do
  let(:user) {
    FactoryBot.create(:user)
  }
  before do
    log_in user
  end

  describe "GET #index" do
    let(:draft) {
      FactoryBot.create(:draft)
    }
    let(:post) {
      FactoryBot.create(:post)
    }
    it "returns http success" do
      get :index
      expect(response.status).to eq 200
    end

    it "assigns drafts" do
      get :index
      expect(assigns(drats)).to contain_exactly draft
    end

    it "render index page" do
      get :index
      expect(response).to render_template 'index'
    end
  end
end
