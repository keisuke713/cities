require 'rails_helper'

RSpec.describe Users::SearchUsersController, type: :controller do
  let(:current_user) {
    FactoryBot.create(:admin_user)
  }

  before do
    log_in current_user
  end

  let!(:user) {
    FactoryBot.create(:user)
  }

  let!(:user2) {
    FactoryBot.create(:other_user)
  }

  describe "GET #index" do

    let(:params) {
      { search: :o }
    }
    it 'returns http success' do
      get :index, params: params
      expect(response.status).to eq 200
    end

    it 'assigns posts' do
      get :index, params: params
      expect(assigns(:users)).to include 'Bob'
    end

    it 'render users/index' do
      get :index, params: params
      expect(response).to render_template 'users/index'
    end
  end
end
