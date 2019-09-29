require 'rails_helper'

RSpec.describe Posts::SearchPostsController, type: :controller do
  let(:current_user) {
    FactoryBot.create(:admin_user)
  }

  before do
    log_in current_user
  end

  describe "GET #index" do
    let!(:post) {
      FactoryBot.create(:post)
    }

    let!(:post2) {
      FactoryBot.create(:child_post)
    }

    let!(:params) {
      { content: :aaa }
    }

    it 'returns http success' do
      get :index, params: params
      expect(:response).to eq 200
    end

    it 'assigns posts' do
      get :index, params: params
      expect(assigns(:posts)).to contain_exactly post
    end

    it 'render posts/index' do
      get :index, params: params
      expect(:response).to render_template 'posts/index'
    end
  end
end
