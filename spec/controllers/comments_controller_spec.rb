require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:admin_user) {
    FactoryBot.create(:admin_user)
  }

  before do
    log_in admin_user
  end

  let(:post) {
    admin_user.posts.create(FactoryBot.attributes_for(:post))
  }

  let(:user) {
    FactoryBot.create(:user)
  }

  before do
    log_in user
  end

  let(:valid_attributes) {
    FactoryBot.attributes_for(:comment)
  }

  let(:post_params) {
    { post_id: post.id }
  }

  describe "GET #index" do
    let(:comment) {
      admin_user.comments.create(valid_attributes, post: post)
    }

    it "returns a 200 response" do
      get :index, params: post_params
      expect(response.status).to eq200
    end

    it "assigned the post" do
      get :index, params: post_params
      expect(assign(:comments)).to include comment
    end

    it "render index" do
      get :index, params: post_params
      expect(response).to render_template 'index'
    end
  end

  describe "GET #new" do
    it "returns a 200 response" do
      get :new, params: post_params
      expect(response.status).to eq 200
    end

    it "assigned the post" do
      get :new, params: post_params
      expect(assigns(:post)).to eq post
    end

    it "render new" do
      get :new, params: post_params
      expect(response).to render_template 'new'
    end
  end

  describe "POST #create" do
    context "parameter is reasonable" do
      it "is registered" do
        binding.pry
        expect {
          post :create, params: { post_id: post.id, comment: valid_attributes }
        }.to change(Comment, :count).by(1)
      end

      it "redirect post page" do
        post :create, params: { post_id: post.id, comment: valid_attributes }
        expect(response).to render_template 'index'
      end
    end

    context "parameter isn't reasonable" do
      let(:invalid_attributes) {
        FactoryBot.attributes_for(:comment, content: nil)
      }
      it "isn't registered" do
        expect {
          post :create, params: { post_id: post.id, comment: invalid_attributes }
        }.to_not change(Comment, :count)
      end

      it "rendered new page" do
        post :create, params: { post_id: post.id, comment: invalid_attributes }
        expect(response).to render_template 'new'
      end
    end
  end
end
