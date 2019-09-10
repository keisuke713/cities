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
end
