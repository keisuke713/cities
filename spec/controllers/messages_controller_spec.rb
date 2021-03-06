require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:message) {
    FactoryBot.create(:message)
  }

  before do
    log_in message.sender
  end

  describe "GET #index" do
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
    let(:attributes) {
      receiver = { receiver_id: message.receiver.id }
      FactoryBot.attributes_for(:message).merge(receiver)
    }

    let(:params) {
      { user_id: message.sender.id, message: attributes }
    }

    context 'when everything is right' do
      it 'insert new record' do
        expect {
          post :create, params: params
        }.to change(Message, :count).by(1)
      end

      it 'redirect show page' do
        post :create, params: params
        expect(response).to redirect_to user_message_url(message.sender.id, message.receiver.id)
      end
    end

    context "when everything isn't right" do
      before do
        params[:message][:content] += 'a'
      end

      it "don't insert new record" do
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
    let!(:receive_message) {
      FactoryBot.create(:receive_message)
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
      expect(assigns(:messages)).to include receive_message
    end

    it 'render show page' do
      get :show, params: params
      expect(response).to render_template 'show'
    end
  end
end
