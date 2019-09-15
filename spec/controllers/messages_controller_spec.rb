require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  describe "GET #index" do
    let(:message) {
      FactoryBot.create(:message)
    }
    let(:params) {
      { user_id: message.sender.id }
    }
    it 'returns a 200 response' do
      get :index, params: params
      expect(response.status).to eq 200
    end

    it 'assigns users' do
      get :index, params: params
      expect(assigns(:users)).to include message.receiver
    end

    it 'render index page' do
      get :index, params: params
      expect(response).to render_template 'index'
    end
  end

  describe "POST #create" do
    let(:message) {
      FactoryBot.build(:message)
    }
    let(:params) {
      { user_id: message.sender.id, id: message.receiver.id }
    }
    context 'when everything is right' do
      it 'insert new record' do
        expect {
          post :create, params: params
        }.to change(Message, :count).by(1)
      end

      it 'redirect show page' do
        post :create, params: params
        expect(response).to redirect_to user_message_url(message.receiver.id)
      end
    end

    context "when everything isn't right" do
      before do
        message.content += 'a'
      end
      it "don't insert new record" do
        binding.pry
        expect {
          post :create, params: params
        }.to_not change(Message, :count)
      end

      it 'render show page' do
        post :create, params: params
        expect(response).to render_template 'show'
      end
    end
  end

  describe 'GET #show' do
    let(:message) {
      FactoryBot.create(:message)
    }

    let(:params) {
      { user_id: message.sender.id, id: message.receiver.id }
    }
    it 'returns a 200 response' do
      get :show, params: params
      expect(response.status).to eq 200
    end

    it 'assigns messages' do
      get :show, params: params
      expect(assigns(:messages)).to include message
    end

    it 'render show page' do
      get :show, params: params
      expect(response).to render_template 'show'
    end
  end
end
