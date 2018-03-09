require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    before do
      @user = FactoryBot.create(:user)
    end

    it "can get it" do
      sign_in @user
      get :show, params: { id: @user.id }
      expect(response.status).to eq 200
    end
  end
end
