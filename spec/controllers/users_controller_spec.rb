require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:valid_attributes) {
    FactoryBot.attributes_for(:user)
  }

  let(:invalid_attributes) {
    FactoryBot.attributes_for(:user, name: nil)
  }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to be_success
    end

    it "returns a 200 response" do
      get :new
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context 'parametaor is reasonable' do
      it "can save" do
        expect do
          post :create, params: { user: valid_attributes }
        end.to change(User, :count).by(1)
      end

      it "assign new user to @user" do
        post :create, params: { user: valid_attributes }
        expect(assigns(:user)).to be_a User
        expect(assigns(:user)).to be_persisted
      end

      it "reidrect user page" do
        post :create, params: { user: valid_attributes }
        expect(response).to redirect_to User.last
      end
    end

    context "parametaor isn't reasonable" do

      it "can save" do
        expect do
          post :create, params: { user: invalid_attributes }
        end.to_not change(User, :count)
      end

      it "redirect new page" do
        post :create, params: { user: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #show" do
    it "returns http success" do
      user = User.create! valid_attributes
      get :show, params: { id: user.id }
      expect(response).to be_success
    end

    it "assigned the user" do
      user = User.create! valid_attributes
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq user
    end

    it "returns a 200 response" do
      user = User.create! valid_attributes
      get :show, params: { id: user.id }
      expect(response.status).to eq 200
    end
  end

  describe "GET #edit" do
  end

  describe "POST #update" do
  end

end
