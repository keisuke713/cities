require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) {
    FactoryBot.attributes_for(:user)
  }

  let(:invalid_attributes) {
    FactoryBot.attributes_for(:user, name: nil)
  }

  describe "GET #index" do
    before do
      log_in user
    end

    let(:user) {
      FactoryBot.create(:user)
    }

    it "returns http success" do
      get :index
      expect(response).to be_successful
    end

    it "assign all users" do
      get :index
      expect(assigns(:users)).to include user
      # expect(assigns(:users)).to match_array [user]
    end

    it "returns a 200 response" do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      get :new
      expect(response.status).to eq 200
    end
  end

  describe "POST #create" do
    context 'parameter is reasonable' do
      it "can save" do
        expect do
          post :create, params: { user: valid_attributes }
        end.to change(User, :count).by(1)
      end

      it "assign new user" do
        post :create, params: { user: valid_attributes }
        expect(assigns(:user)).to be_a User
        expect(assigns(:user)).to be_persisted
      end

      it "reidrect user page" do
        post :create, params: { user: valid_attributes }
        expect(response).to redirect_to User.last
      end
    end

    context "parameter isn't reasonable" do

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
    let(:user) {
      FactoryBot.create(:user)
    }

    it "returns http success" do
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end

    it "assigned the user" do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq user
    end

    it "returns a 200 response" do
      get :show, params: { id: user.id }
      expect(response.status).to eq 200
    end
  end

  describe "GET #edit" do
    let(:user) {
      FactoryBot.create(:user)
    }

    before do
      log_in user
    end

    it "returns http success" do
      get :edit, params: { id: user.id }
      expect(response).to be_successful
    end

    it "assigned the user" do
      get :edit, params: { id: user.id }
      expect(assigns(:user)).to eq user
    end

    it "returns a 200 response" do
      get :edit, params: { id: user.id }
      expect(response.status).to eq 200
    end
  end

  describe "POST #update" do
    let(:user) {
      FactoryBot.create(:user)
    }

    before do
      log_in user
    end

    context "parametar is reasonable" do
      let(:new_attributes) {
        FactoryBot.attributes_for(:user, name: 'new_user')
      }

      it "update user" do
        put :update, params: { id: user.id, user: new_attributes }
        user.reload
        expect(user.name).to eq 'new_user'
      end

      it "assign updated user" do
        put :update, params: { id: user.id, user: new_attributes }
        expect(assigns(:user)).to eq user
      end

      it "redirect user page" do
        put :update, params: { id: user.id, user: new_attributes }
        expect(response).to redirect_to user
      end
    end

    context "parameter isn't reasonable" do
      it "assign user but update" do
        put :update, params: { id: user.id, user: invalid_attributes }
        expect(assigns(:user)).to eq user
      end

      it "rendirect edit page" do
        put :update, params: { id: user.id, user: invalid_attributes }
        expect(assigns(:user)).to render_template 'edit'
      end
    end
  end

  describe "DELETE #destory" do
    let!(:admin_user) {
      FactoryBot.create(:admin_user)
    }

    let!(:user) {
      FactoryBot.create(:user)
    }

    before do
      log_in admin_user
    end

    it "delete user" do
      expect do
        delete :destroy, params: { id: user.id }
      end.to change(User, :count).by(-1)
    end

    it "redirect users page" do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to users_path
    end
  end

end
