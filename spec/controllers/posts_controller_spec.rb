require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:user) {
    FactoryBot.create(:user)
  }

  before do
    log_in user
  end

  xdescribe "GET #index" do
    let(:post) {
      FactoryBot.create(:post)
    }

    it "returns http success" do
      get :index
      expect(response).to be_successful
    end

    it "assign all posts" do
      get :index
      expect(assigns(:psots)).to include post
    end

    it "returns a 200 status" do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe "GET #new" do
    let(:user_params) {
      { user_id: user.id }
    }

    it "returns http success" do
      get :new, params: user_params
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      get :new, params: user_params
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context "parameter is reasonable" do
      let(:valid_attributes) {
        FactoryBot.attributes_for(:post)
      }

      it "is registered" do
        expect {
          post :create, params: { user_id: user.id, post: valid_attributes }
        }.to change(Post, :count).by(1)
      end

      it "redirect user page" do
        post :create, params: { user_id: user.id, post: valid_attributes }
        expect(response).to redirect_to user
      end
    end

    context "parameter isn't reaonable" do
      let(:invalid_attributes) {
        FactoryBot.attributes_for(:post, content: nil)
      }

      it "isn't registered" do
        expect {
          post :create, params: { user_id: user.id, post: invalid_attributes }
        }.to_not change(Post, :count)
      end

      it "redirect new page" do
        post :create, params: { user_id: user.id, post: invalid_attributes }
        expect(response).to render_template 'new'
      end
    end
  end

  describe "GET #show" do
    let(:post) {
      FactoryBot.create(:post, user_id: user.id)
    }

    let(:post_params) {
      { id: post.id }
    }

    it "returns htttp success" do
      get :show, params: post_params
      expect(response).to be_successful
    end

    it "assigned the post" do
      get :show, params: post_params
      expect(assigns(:post)).to eq post
    end

    it "returns a 200 response" do
      get :show, params: post_params
      expect(response.status).to eq 200
    end
  end
end
