require 'rails_helper'

RSpec.describe Reply, type: :model do
  let(:reply) {
    FactoryBot.build(:reply)
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
