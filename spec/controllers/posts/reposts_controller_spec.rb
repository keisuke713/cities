require 'rails_helper'

RSpec.describe Posts::RepostsController, type: :controller do
  let(:user) {
    FactoryBot.create(:user)
  }

  before do
    log_in user
  end

  let!(:parent_post) {
    FactoryBot.create(:post)
  }

  describe "GET #new" do
    let(:params) {
      { post_id: parent_post.id }
    }

    it "returns a 200 response" do
      get :new, params: params
      expect(response.status).to eq 200
    end

    it "assigns parent_post" do
      get :new, params: params
      expect(assigns(:parent_post)).to eq parent_post
    end

    it "render new page" do
      get :new, params: params
      expect(response).to render_template 'new'
    end
  end

  describe "POST #create" do
    let(:attributes) {
      FactoryBot.attributes_for(:child_post)
    }

    let(:params) {
      { post_id: parent_post.id, post: attributes }
    }

    context "when parameter is reasonable" do
      it "is inserted new record" do
        expect {
          post :create, params: params
        }.to change( Post, :count ).by(1)
      end

      it "is redirect_to show page" do
        post :create, params: params
        expect(response).to redirect_to user
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
        expect(response).to render_template 'new'
      end
    end
  end
end
