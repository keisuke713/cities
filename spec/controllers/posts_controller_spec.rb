require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:user) {
    FactoryBot.create(:user)
  }
  
  before do
    log_in user
  end

  let(:valid_attributes) {
    FactoryBot.attributes_for(:post)
  }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      get :new
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context "parameter is reasonable" do
      it "is registered" do
        expect {
          post :create, params: { post: valid_attributes }
        }.to change(Post, :count).by(1)
      end

      it "redirect user page" do
        post :create, params: { post: valid_attributes }
        expect(response).to redirect_to user_path
      end
    end

    context "parameter isn't reaonable" do
      let(:invalid_attributes) {
        FactoryBot.attributes_for(:post, content: nil)
      }

      it "isn't registered" do
        expect {
          post :create, params: { post: invlaid_attributes }
        }.to_not change(Post, :count)
      end

      it "redirect new page" do
        post :create, params: { post: invalid_attributes }
        expect(response).to render_template 'new'
      end
    end
  end
end
