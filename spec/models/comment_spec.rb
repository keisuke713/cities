require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) {
    FactoryBot.create(:user)
  }

  let(:post_attributes) {
    FactoryBot.attributes_for(:post)
  }

  let(:post) {
    user.posts.create(post_attributes)
  }

  let(:valid_attributes) {
    FactoryBot.attributes_for(:comment)
  }

  let(:comment_attributes) {
    valid_attributes.merge(post: post)
  }

  let(:comment) {
    user.comments.build(comment_attributes)
  }

  it 'is valid with content' do
    expect(comment).to be_valid
  end

  it 'is invalid without content' do
    comment.content = nil
    expect(comment).to be_invalid
  end

  it 'is invalid with content too long' do
    comment.content = 'a' * 141
    expect(comment).to be_invalid
  end
end
