require 'rails_helper'

RSpec.describe Reply, type: :model do
  let(:user) {
    FactoryBot.create(:user)
  }

  let(:comment) {
    comment = user.comments.build(FactoryBot.attributes_for(:comment))
    comment.post = user.posts.create(FactoryBot.attributes_for(:post))
    comment.save
    comment
  }

  let(:valid_attributes) {
    FactoryBot.attributes_for(:reply)
  }

  let(:reply_attributes) {
    valid_attributes.merge(comment: comment)
  }

  let(:reply) {
    user.replies.build(reply_attributes)
  }

  describe "reply_validation" do
    it 'is valid with content' do
      expect(reply).to be_valid
    end

    it 'is invalid with content' do
      reply.content = nil
      expect(reply).to be_invalid
    end

    it 'is invlaid with content too long' do
      reply.content = 'a' * 141
      expect(reply).to be_invalid
    end
  end
end
