require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  let(:user) {
    FactoryBot.create(:user)
  }

  before do
    log_in user
  end

  describe "POST #create" do
    let(:other_user) {
      FactoryBot.create(:admin_user)
    }
    let(:valid_params) {
      { user_id: other_user.id }
    }
    it "is registered" do
      expect {
        post :create, params: valid_params
      }.to change( Relationship, :count).by(1)
    end

    it "redirect user page" do
      post :create, params: valid_params
      expect(response).to redirect_to user_url(other_user.id)
    end
  end

  describe "DELETE #destroy" do
    let(:relationship) {
      FactoryBot.create(:relationship)
    }
    let(:relationship_params) {
      { user_id: relationship.followed.id, id: relationship.id }
    }
    it "return http success" do
      delete :destory, params: relationship_params
      expect(response).to eq 200
    end

    it "delete relationsip" do
      expect{
        delete :destory, params: relationship_params
      }.to change( Relationship, :count).by(-1)
    end

    it "redirect user page" do
      delete :destory, params: relationship_params
      expect(response).to redirect_to user_url(relationship.followed.id)
    end
  end
end
