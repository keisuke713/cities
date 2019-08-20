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

  let(:comment) {
    comment = user.comments.build(FactoryBot.attributes_for(:comment))
    comment.post = user_post
    comment.save
    comment
  }

  let(:valid_attributes) {
    valid_attributes = FactoryBot.attributes_for(:reply)
    valid_attributes.merge(user_id: user.id)
    valid_attributes.merge(comment_id: comment.id)
  }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

end
