require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) {
    FactoryBot.create(:user)
  }

  let(:valid_attributes) {
    FactoryBot.attributes_for(:post)
  }

  let(:post) {
    FactoryBot.build(:post)
  }

  let!(:post1) {
    FactoryBot.create(:post)
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
    context 'when post has comments' do
      let!(:comment) {
        FactoryBot.create(:comment)
      }
      it 'ia deleted related comment when post is deleted' do
        expect{ comment.post.destroy }.to change{ Comment.count }.by(-1)
      end
    end

    context 'when post has book_marks' do
      let!(:book_mark) {
        FactoryBot.create(:book_mark)
      }
      it "is deleted related bookmark when post is related" do
        expect{ book_mark.post.destroy }.to change{ BookMark.count }.by(-1)
      end
    end
  end

  describe "instance method" do
    let(:post2) {
      post1.tap do |p|
        p.content = 'a' * 140
        p.save
      end
    }
    it 'text_slice' do
      expect(post2.text_slice).to eq 'a' * 20 + '...'
    end
  end
end
