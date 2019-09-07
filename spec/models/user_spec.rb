require 'rails_helper'

RSpec.describe User, type: :model do

  let!(:user) {
    FactoryBot.build(:user)
  }

  describe "user_validation" do
    it "is valid with name, email and age" do
      expect(user).to be_valid
    end

    it "name is blank" do
      user.name = ''
      expect(user).to be_invalid
    end

    it "email is blank" do
      user.email = ''
      expect(user).to be_invalid
    end

    it "email should be uniqueness" do
      duplicate_user = user.dup
      user.save!
      expect(duplicate_user).to be_invalid
    end

    it "intro is blank" do
      user.intro = ''
      expect(user).to be_invalid
    end

    it "password is blank" do
      user.password = user.password_confirmation = ''
      expect(user).to be_invalid
    end

    it "the first letter of password is downcase" do
      user.password = 'baseball713'
      expect(user).to be_invalid
    end

    it "the length of password is less than eight character" do
      user.password = 'Basebal'
      expect(user).to be_invalid
    end

    it "can save" do
      expect(user).to be_truthy
    end
  end

  describe "user_association" do
    context 'when user has posts' do
      let!(:post) {
        FactoryBot.create(:post)
      }
      it "is deleted related post when user is deleted" do
        expect{ post.user.destroy }.to change{ Post.count }.by(-1)
      end
    end

    context 'when user has comments' do
      let!(:comment) {
        FactoryBot.create(:comment)
      }
      it "is deleted related comment when user is deleted" do
        expect{ comment.user.destroy }.to change{ Comment.count }.by(-1)
      end
    end

    context 'when user has replies' do
      let!(:reply) {
        FactoryBot.create(:reply)
      }
      it "is deleted related reply when user is deleted" do
        expect{ reply.user.destroy }.to change{ Reply.count }.by(-1)
      end
    end

    context 'when user has book_marks' do
      let!(:book_mark) {
        FactoryBot.create(:book_mark)
      }
      it "is deleted related book_mark when user is deleted" do
        expect{ book_mark.user.destroy }.to change{ BookMark.count }.by(-1)
      end
    end

    context 'when user follow other user' do
      let!(:relationship) {
        FactoryBot.create(:relationship)
      }
      it 'is deleted relationship when follower is deleted' do
        expect{ relationship.follower.destroy }.to change{ Relationship.count }.by(-1)
      end

      it 'is deleted relationship when followed is deleted' do
        expect{ relationship.followed.destroy }.to change{ Relationship.count }.by(-1)
      end
    end
  end
end
