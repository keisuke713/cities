require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) {
    FactoryBot.build(:comment)
  }

  describe "comment_validation" do
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

  describe "comment_association" do
    context 'when comment has replies' do
      let!(:reply) {
        FactoryBot.create(:reply)
      }
      it "is deleted related reply when comment is deleted" do
        expect{ reply.comment.destroy }.to change{ Reply.count }.by(-1)
      end
    end
  end
end
