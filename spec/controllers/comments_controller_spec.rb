require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) {
    FactoryBot.create(:admin_user)
  }

  before do
    log_in user
  end

  let(:user_post) {
    user.posts.create(FactoryBot.attributes_for(:post))
  }

  let(:valid_attributes) {
    FactoryBot.attributes_for(:comment)
  }

  let(:post_params) {
    { post_id: user_post.id }
  }

  describe "GET #new" do
    it "returns a 200 response" do
      get :new, params: post_params
      expect(response.status).to eq 200
    end

    it "assigned the post" do
      get :new, params: post_params
      expect(assigns(:post)).to eq user_post
    end

    it "render new" do
      get :new, params: post_params
      expect(response).to render_template 'new'
    end
  end

  describe "POST #create" do
    context "parameter is reasonable" do
      it "is registered" do
        expect {
          post :create, params: { user_id: user.id, post_id: user_post.id, comment: valid_attributes }, session: {}
        }.to change(Comment, :count).by(1)
      end

      it "redirect post page" do
        post :create, params: { user_id: user.id, post_id: user_post.id, comment: valid_attributes }, session: {}
        expect(response).to redirect_to user_post
      end
    end

    context "parameter isn't reasonable" do
      let(:invalid_attributes) {
        FactoryBot.attributes_for(:comment, content: nil)
      }
      it "isn't registered" do
        expect {
          post :create, params: { user_id: user.id, post_id: user_post.id, comment: invalid_attributes }
        }.to_not change(Comment, :count)
      end

      it "rendered new page" do
        post :create, params: { user_id: user.id, post_id: user_post.id, comment: invalid_attributes }
        expect(response).to render_template 'new'
      end
    end
  end

  describe "GET #show" do
    let(:comment) {
      comment = user.comments.build(valid_attributes)
      comment.post = user_post
      comment.save
      comment
    }

    let(:comment_params) {
      { id: comment.id }
    }

    it "returns http success" do
      get :show, params: comment_params
      expect(response.status).to eq 200
    end

    it "assigns comment" do
      get :show, params: comment_params
      expect(assigns(:comment)).to eq comment
    end

    it "assigns replies" do
      reply = user.replies.build(FactoryBot.attributes_for(:reply))
      reply.comment = comment
      reply.save
      get :show, params: comment_params
      expect(assigns(:replies)).to include reply
    end

    it "render show" do
      get :show, params: comment_params
      expect(response).to render_template 'show'
    end
  end

end
