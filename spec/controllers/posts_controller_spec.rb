require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) {
    FactoryBot.create(:admin_user)
  }

  before do
    log_in user
  end

  describe "GET #index" do
    let(:post) {
      FactoryBot.create(:post)
    }
    before do
      user.active_relationships.create(followed_id: post.user.id)
    end
    let(:user_params) {
      { user_id: user.id }
    }
    it "returns http success" do
      get :index, params: user_params
      expect(response.status).to eq 200
    end

    it "assign all posts" do
      get :index, params: user_params
      expect(assigns(:posts)).to include post
    end

    it "render index page" do
      get :index, params: user_params
      expect(response).to render_template 'index'
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
      let!(:valid_attributes) {
        FactoryBot.attributes_for(:post)
      }
      let(:valid_params) {
         { user_id: user.id, post: valid_attributes }
      }
      it "is registered" do
        expect {
          post :create, params: valid_params
        }.to change(Post, :count).by(1)
      end

      it "redirect user page" do
        post :create, params: valid_params
        expect(response).to redirect_to user
      end
    end

    context "parameter isn't reaonable" do
      let(:invalid_attributes) {
        FactoryBot.attributes_for(:post, content: nil)
      }
      let(:invalid_params) {
        { user_id: user.id, post: invalid_attributes }
      }
      it "isn't registered" do
        expect {
          post :create, params: invalid_params
        }.to_not change(Post, :count)
      end

      it "redirect new page" do
        post :create, params: invalid_params
        expect(response).to render_template 'new'
      end
    end

    context "save as draft" do
      let(:draft_attributes) {
        FactoryBot.attributes_for(:draft)
      }
      let(:draft_params) {
        { user_id: user.id, post: draft_attributes, draft_status: 1 }
      }
      it "draft_status = 1" do
        post :create, params: draft_params
        expect(controller.instance_variable_get("@post").draft_status).to eq 1
      end
    end
  end

  describe "GET #show" do
    let(:post) {
      FactoryBot.create(:post)
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

    it "assigned comments" do
      comment = FactoryBot.create(:comment)
      get :show, params: post_params
      expect(assigns(:comments)).to include comment
    end

    it "returns a 200 response" do
      get :show, params: post_params
      expect(response.status).to eq 200
    end
  end
end
