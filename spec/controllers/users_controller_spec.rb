require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    let(:user) { create(:user) }
    let(:user2) { create(:user, name: "taro", email: "test2@example.com") }

    context "as logged in" do
      before { sign_in user }

      context "as an authorized user" do
        before { get :show, params: { id: user.id } }

        it "responds successfully" do
          expect(response).to be_success
          expect(response.status).to eq 200
        end

        it "assigns the requested user to @user" do
          expect(assigns(:user)).to eq user
        end
      end

      context "as an unauthorized user" do
        before { get :show, params: { id: user2.id } }

        it "redirect_to root_url" do
          expect(response).to redirect_to root_url
          expect(response.status).to eq 302
        end
      end
    end

    context "as not logged in" do
      it "returns a 302 response" do
        get :show, params: { id: user.id }
        expect(response).to redirect_to new_user_session_url
        expect(response.status).to eq 302
      end
    end
  end
end
