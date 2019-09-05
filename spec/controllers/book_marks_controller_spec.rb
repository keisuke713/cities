require 'rails_helper'

RSpec.describe BookMarksController, type: :controller do
  let(:user) {
    FactoryBot.create(:user)
  }

  before do
    log_in user
  end

  describe "GET #index" do
    let(:user_params) {
      { user_id: user.id }
    }
    let(:book_mark) {
      FactoryBot.create(:book_mark)
    }
    it "returns http success" do
      get :index, params: user_params
      expect(response.status).to eq 200
    end

    it "assign post" do
      post = Post.find(book_mark.post_id)
      get :index, params: user_params
      expect(assigns(:posts)).to include post
    end

    it "render index" do
      get :index, params: user_params
      expect(response).to render_template 'index'
    end
  end

  describe "POST #create" do
    let(:user_post) {
      FactoryBot.create(:post)
    }
    let(:book_mark_params) {
      { user_id: user.id, post_id: user_post.id }
    }
    it "is registered" do
      expect {
        post :create, params: book_mark_params
      }.to change( BookMark, :count ).by(1)
    end

    it "redirect post page" do
      post :create, params: book_mark_params
      expect(response).to redirect_to post_url(user_post.id)
    end
  end

  describe "DELETE #destroy" do
    let!(:user_post) {
      FactoryBot.create(:post)
    }
    let(:book_mark) {
      FactoryBot.create(:book_mark)
    }
    let!(:book_mark_params) {
      { post_id: user_post.id, id: book_mark.id }
    }
    it "delete book_mark" do
      expect {
        delete :destroy, params: book_mark_params
      }.to change(BookMark, :count).by(-1)
    end

    it "redirect post page" do
      delete :destroy, params: book_mark_params
      expect(response).to redirect_to post_path
    end
  end
end
