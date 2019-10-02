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
    FactoryBot.create(:user2)
  }

  let!(:user3) {
    FactoryBot.create(:user3)
  }

  describe "GET #index" do
    let!(:params) {
      { name: 'Bob' }
    }
    it 'returns http success' do
      get :index, params: params
      expect(response.status).to eq 200
    end

    it 'render users/index' do
      get :index, params: params
      expect(response).to render_template 'users/index'
    end

    context 'when forward_match' do
      let!(:forward_params) {
        { name: :B, search_method: :forward_match }
      }
      it 'assigns users' do
        get :index, params: forward_params
        expect(assigns(:users)).to contain_exactly user, user3
      end
    end

    context 'when backward_match' do
      let!(:backward_params) {
        { name: :b, search_method: :backward_match }
      }
      it 'assigns users' do
        get :index, params: backward_params
        expect(assigns(:users)).to contain_exactly user, user2
      end
    end

    context 'when perfect_match' do
      let!(:perfect_params) {
        { name: :Bob, search_method: :perfect_match }
      }
      it 'assigns users' do
        get :index, params: perfect_params
        expect(assigns(:users)).to contain_exactly user
      end
    end

    context 'when exclude' do
      let!(:exclude_params) {
        { name: :Bob, search_method: :exclude }
      }
      it 'assigns users' do
        get :index, params: exclude_params
        expect(assigns(:users)).to contain_exactly current_user, user2, user3
      end
    end
  end
end
