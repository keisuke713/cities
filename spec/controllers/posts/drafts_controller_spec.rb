require 'rails_helper'

RSpec.describe Posts::DraftsController, type: :controller do
  let(:user) {
    FactoryBot.create(:user)
  }
  before do
    log_in user
  end

  describe "GET #index" do
    let!(:post) {
      FactoryBot.create(:post)
    }
    let!(:draft) {
      FactoryBot.create(:draft)
    }
    let(:params) {
      { user_id: user.id }
    }
    it "returns http success" do
      get :index, params: params
      expect(response.status).to eq 200
    end

    it "assigns drafts" do
      get :index, params: params
      expect(assigns(:drafts)).to contain_exactly draft
    end

    it "render index page" do
      get :index, params: params
      expect(response).to render_template 'index'
    end
  end

  describe "GET #edit" do
    let!(:draft) {
      FactoryBot.create(:draft)
    }
    let(:params) {
      { id: draft.id }
    }
    it "returns http success" do
      get :edit, params: params
      expect(response.status).to eq 200
    end

    it "assign draft" do
      get :edit, params: params
      expect(assigns(:draft)).to eq draft
    end

    it "render edit page" do
      get :edit, params: params
      expect(response).to render_template 'edit'
    end
  end

  describe "PATCH #update" do
    let!(:draft) {
      FactoryBot.create(:draft)
    }
    let!(:draft_attributes) {
      FactoryBot.attributes_for(:draft)
    }
    context 'when post timeline' do
      before do
        draft_attributes[:status] = :published
      end
      let(:params) {
        { post: draft_attributes, id: draft.id}
      }
      it "can be edited status" do
        patch :update, params: params
        expect(draft.reload.status).to eq 'published'
      end

      it "redirect user page" do
        patch :update, params: params
        expect(response).to redirect_to draft.user
      end
    end

    context 'when save as post' do
      before do
        draft_attributes[:content] = 'update as draft'
      end
      let(:params) {
        { post: draft_attributes, id: draft.id }
      }
      it "can be edited content" do
        patch :update, params: params
        expect(draft.reload.content).to eq 'update as draft'
      end
    end

    context "parameter isn't reasonbale" do
      before do
        draft_attributes[:content] = nil
      end
      let(:params) {
        { post: draft_attributes, id: draft.id }
      }
      it "isn't update" do
        patch :update, params: params
        expect(draft.reload.content).to eq 'a' * 140
      end

      it "render edit" do
        patch :update, params: params
        expect(response).to render_template 'edit'
      end
    end
  end
end
