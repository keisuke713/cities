require 'rails_helper'

RSpec.describe Post::RepostController, type: :controller do
  let(:user) {
    FactoryBot.create(:user)
  }

  before do
    log_in user
  end

  describe "GET #new" do
    let(:parent_post) {
      FactoryBot.create(:post)
    }
    let(:params) {
      { user_id: user.id, post_id: parent_post.id }
    }

    it "returns a 200 response" do
      get :new, params: params
      expect(response.status).to eq 200
    end

    it "assigns parent_post" do
      get :new, params: params
      expect(assigns(:post)).to eq parent_post
    end

    it "render new page" do
      get :new, params: params
      expect(response).to render_template 'new'
    end
  end

  describe "POST #create" do
    let(:attributes) {
      FactoryBot.create(:child_post)
    }

    let(:params) {
      { user_id: user.id, post: attributes }
    }

    context "when parameter is reasonable" do
      it "is inserted new record" do
        expect {
          post :create, params: params
        }.to change( Post, :count ).by(1)
      end

      it "is redirect_to show page" do
        post :create, params: params
        expect(response).redirect_to user
      end
    end

    context "when parameter isn't reasonable" do
      before do
        params[:post][:content] = nil
      end

      it "isn't inserted new record" do
        expect {
          post :create, params: params
        }.to_not change( Post, :count)
      end

      it "render new page" do
        post :create, params: params
        expect(response).render_template 'new'
      end
    end
  end
end
