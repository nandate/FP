require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    let(:user) { create(:user) }

    context "as logged in" do
      before do
        sign_in user
        get :show, params: { id: user.id }
      end

      it "responds successfully" do
        expect(response).to be_success
        expect(response.status).to eq 200
      end

      it "assigns the requested user to @user" do
        expect(assigns(:user)).to eq user
      end
    end

    context "as not logged in" do
      it "returns a 302 response" do
        get :show, params: { id: user.id }
        expect(response).to redirect_to "/users/sign_in"
        expect(response.status).to eq 302
      end
    end
  end
end
