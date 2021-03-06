require 'rails_helper'

RSpec.describe RepliesController, type: :controller do
  let(:user) {
    FactoryBot.create(:user)
  }

  before do
    log_in user
  end

  let!(:comment) {
    FactoryBot.create(:comment)
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
      let(:valid_params) {
        { user_id: user.id, comment_id: comment.id, reply: valid_attributes }
      }
      it "is registered" do
        expect {
          post :create, params: valid_params
        }.to change( Reply, :count ).by(1)
      end

      it "redirect comment page" do
        post :create, params: valid_params
        expect(response).to redirect_to comment
      end
    end

    context "parameter isn't reasonable" do
      let(:invalid_attributes) {
        FactoryBot.attributes_for(:reply, content: nil)
      }
      let(:invalid_params) {
        { user_id: user.id, comment_id: comment.id, reply: invalid_attributes }
      }
      it "isn't registered" do
        expect {
          post :create, params: invalid_params
        }.to_not change( Reply, :count )
      end

      it "render new page" do
        post :create, params: invalid_params
        expect(response).to render_template 'new'
      end
    end
  end

end
