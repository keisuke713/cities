require 'rails_helper'

RSpec.describe RepliesController, type: :controller do
  let(:user) {
    FactoryBot.create(:user)
  }

  before do
    log_in user
  end

  let(:user_post) {
    user.posts.create(FactoryBot.attributes_for(:post))
  }

  let!(:comment) {
    comment = user.comments.build(FactoryBot.attributes_for(:comment))
    comment.post = user_post
    comment.save
    comment
  }

  let(:comment_params) {
    { comment_id: comment.id }
  }

  describe "GET #new" do
    it "returns http success" do
      get :new, params: comment_params
      expect(response.status).to eq 200
    end

    it "assigns comment" do
      get :new, params: comment_params
      expect(assigns(:comment)).to eq comment
    end

    it "render new" do
      get :new, params: comment_params
      expect(response).to render_template 'new'
    end
  end

  describe "GET #create" do
    let(:valid_attributes) {
      FactoryBot.attributes_for(:reply)
    }
    context 'parameter is reasonable' do
      it "is registered" do
        expect {
          post :create, params: { user_id: user.id, comment_id: comment.id, reply: valid_attributes }
        }.to change( Reply, :count ).by(1)
      end

      it "redirect comment page" do
        post :create, params: { user_id: user.id, comment_id: comment.id, reply: valid_attributes }
        expect(response).to redirect_to comment
      end
    end

    context "parameter isn't reasonable" do
      let(:invalid_attributes) {
        FactoryBot.attributes_for(:reply, content: nil)
      }
      it "isn't registered" do
        expect {
          post :create, params: { user_id: user.id, comment_id: comment.id, reply: invalid_attributes }
        }.to_not change( Reply, :count )
      end

      it "render new page" do
        post :create, params: { user_id: user.id, comment_id: comment.id, reply: invalid_attributes }
        expect(response).to render_template 'new'
      end
    end
  end

end
