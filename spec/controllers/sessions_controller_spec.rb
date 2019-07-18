require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context 'parameter is reasonable' do
      session_params = {
        email: 'nebakei.tkb713@gmail.com',
        password: :Baseball713
      }
      it "returns http success" do
        post :create, params: { session: { email: 'nebakei.tkb713@gmail.com', password: 'Baseball713' }}
        expect(response.status).to eq 200
      end

      it "redirect top page" do
        post :create, params: { session: { email: 'nebakei.tkb713@gmail.com', password: 'Baseball713' }}
        expect(response).to be_successful
      end
    end
  end
end
