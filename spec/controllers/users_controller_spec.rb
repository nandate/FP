require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    let(:user) { FactoryBot.create(:user) }

    it "can get it" do
      sign_in user
      get :show, params: { id: user.id }
      expect(response).to be_success
      expect(response.status).to eq 200
    end
  end
end
