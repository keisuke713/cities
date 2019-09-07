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
      FactoryBot.create(:user)
    }
    context 'when paramater is correct' do
      let(:valid_params) {
        { followed_id: user.id, follower_id: other_user.id }
      }
      it "return https success" do
        post :create, params: valid_params
        expect(response).to eq 200
      end

      it "is registered" do
        expect {
          post :create, params: valid_params
        }.to change( Relationship, :count).by(1)
      end

      it "redirect user page" do
        post :create, params: valid_params
        expect(response).to redirect user_url(other_user.id)
      end
    end

    context 'when paramater is not correct' do
      let(:invalid_params) {
        { follower_id: user.id }
      }
      it "return htttps success" do
        post :create, params: invalid_params
        expect(response).to eq 200
      end

      it "is't registered" do
        expect{
          post :create, params: invalid_params
        }.to_not change( Relationship, :count)
      end

      it "render user page" do
        post :create, params: invalid_params
        expect(response).to render_template 'user/show'
      end
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
