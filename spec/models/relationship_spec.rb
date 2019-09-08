require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe "validation" do
    let(:relationship) {
      FactoryBot.build(:relationship)
    }
    context 'when valid' do
      it 'is valid' do
        expect(relationship).to be_valid
      end
    end

    context 'when invalid' do
      it 'follower_id is blank' do
        relationship.follower_id = ''
        expect(relationship).to be_invalid
      end

      it 'followed_id is blank' do
        relationship.followed_id = ''
        expect(relationship).to be_invalid
      end
    end
  end

  describe "self.check" do
    context "when it exists relationship" do
      let(:relationship) {
        FactoryBot.create(:relationship)
      }
      let(:user) {
        relationship.follower
      }
      let(:user2) {
        relationship.followed
      }
      it 'return true' do
        expect(Relationship.check(user, user2)).to be true
      end
    end

    context "when it doesn't relationship" do
      let(:user) {
        FactoryBot.create(:admin_user)
      }
      let(:user2) {
        FactoryBot.create(:user)
      }
      it 'return false' do
        expect(Relationship.check(user, user2)).to be false
      end
    end
  end
end
