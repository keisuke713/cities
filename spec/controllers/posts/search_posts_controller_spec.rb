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

    let!(:post3) {
      FactoryBot.create(:post_by_Cob)
    }

    let!(:post4) {
      FactoryBot.create(:child_post_by_Cob)
    }

    context 'search_post_by_Bob' do
      let!(:params) {
        { keyword: :Bob, seach_method: :user_match}
      }

      it 'returns http success' do
        get :index, params: params
        expect(response.status).to eq 200
      end

      it 'assigns posts' do
        get :index, params: params
        expect(assigns(:posts)).to contain_exactly post, post2
      end

      it 'render posts/index' do
        get :index, params: params
        expect(:response).to render_template 'posts/index'
      end
    end

    context 'search_post_by_Cob' do
      let!(:params) {
        { keyword: :Cob, seach_method: :user_match }
      }

      it 'assigns posts' do
        get :index, params: params
        expect(assigns(:posts)).to contain_exactly post3, post4
      end
    end

    context 'search_post_included_aaa' do
      let!(:params) {
        { keyword: :aaa, seach_method: :content_match }
      }

      it 'assigns posts' do
        get :index, params: params
        expect(assigns(:posts)).to contain_exactly post, post3
      end
    end

    context 'search_post_included_child' do
      let!(:params) {
        { keyword: :child, seach_method: :content_match}
      }

      it 'assigns posts' do
        get :index, params: params
        expect(assigns(:posts)).to contain_exactly post2, post4
      end
    end
  end
end
