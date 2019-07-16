require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context 'parametaor is reasonable' do
      user_params = {
        name: 'keisuke',
        email: 'nebakei.tkb713@gmail.com',
        age: 23,
        password: 'Baseball713'
      }
      it "returns http success" do
        post :create, params: { user: user_params }
        expect(response.status).to eq 302
      end

      it "can save" do
        expect do
          post :create, params: { user: user_params }
        end.to change(User, :count).by(1)
      end

      it "reidrect user page" do
        post :create, params: { user: user_params }
        expect(response).to redirect_to root_path
      end
    end

    context "parametaor isn't reasonable" do
      user_params = {
        name: '',
        email: 'nebakei.tkb713@gmail.com',
        age: 23,
        password: 'Baseball713'
      }

      it "returns http success" do
        post :create, params: { user: user_params }
        expect(response.status).to eq 200
      end

      it "can save" do
        expect do
          post :create, params: { user: user_params }
        end.to_not change(User, :count)
      end
    end
  end

end
