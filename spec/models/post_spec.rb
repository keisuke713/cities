require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) {
    FactoryBot.create(:user)
  }

  let(:valid_attributes) {
    FactoryBot.attributes_for(:post)
  }

  let(:post) {
    user.posts.build(valid_attributes)
  }

  let!(:post1) {
    user.posts.create(valid_attributes)
  }

  describe "post_validation_and_scope" do
    it 'is valid with content, image, user_id' do
      expect(post).to be_valid
    end

    it 'is invalid without content' do
      post.content = ''
      post.valid?
      expect(post).to be_invalid
    end

    it 'is invalid with content too long' do
      post.content = 'a' * 141
      post.valid?
      expect(post).to be_invalid
    end

    it 'is invlaid without user_id ' do
      post.user_id = nil
      post.valid?
      expect(post).to be_invalid
    end

    it 'is descending order' do
      user.posts.create(valid_attributes)
      expect(Post.first.id).to eq 2
    end
  end

  describe "post_association" do
    let(:comment_attributes) {
      FactoryBot.attributes_for(:comment).merge(post: post)
    }
    it 'ia deleted related comment when post is deleted' do
      comment = user.comments.build(comment_attributes)
      comment.save
      expect{ post.destroy }.to change{ Comment.count }.by(-1)
    end
  end
end
