require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    let(:user) { create(:user) }

    context "as logged in" do
      before do
        sign_in user
      end

      it "responds successfully" do
        get :show, params: { id: user.id }
        expect(response).to be_success
        expect(response.status).to eq 200
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
