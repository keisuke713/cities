require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validation' do
    let(:message) {
      FactoryBot.create(:message)
    }
    context 'when everything is right' do
      it 'is valid' do
        expect(message).to be_valid
      end
    end

    context 'when context is over 140' do
      before do
        message.content = 'a' * 141
      end
      it 'is invalid' do
        expect(message).to be_invalid
      end
    end

    context 'when sender is null' do
      before do
        message.sender = nil
      end
      it 'is invalid' do
        expect(message).to be_invalid
      end
    end

    context 'when receiver is null' do
      before do
        message.receiver = nil
      end
      it 'is invalid' do
        expect(message).to be_invalid
      end
    end
  end
end
