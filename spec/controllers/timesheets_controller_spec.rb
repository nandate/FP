require 'rails_helper'

RSpec.describe TimesheetsController, type: :controller do
  let(:fp_user) { create(:fp_user) }
  let(:normal_user) { create(:user) }
  let(:timesheet) { create(:timesheet, user: fp_user) }
  let(:invalid_timesheet) { create(:timesheet) }
  let(:timesheets) { Timesheet.all.order_by_start_time }
  let(:timesheet_params) { attributes_for(:timesheet) }

  describe 'GET #index' do
    context 'as logged in' do
      before do
        sign_in fp_user
        get :index
      end

      it 'return a 200 response' do
        expect(response.status).to eq 200
      end

      it 'assigns the requested timesheets to @timesheets' do
        expect(assigns(:timesheets)).to match_array timesheets
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end

    context 'as not logged in' do
      it 'returns a 302 response ' do
        get :index
        expect(response).to redirect_to "/users/sign_in"
        expect(response.status).to eq 302
      end
    end
  end

  describe 'GET #show' do
    context 'as authorized user' do
      before do
        sign_in fp_user
        get :show, params: { id: timesheet.id }
      end

      it 'return a 200 response' do
        expect(response.status).to eq 200
      end

      it 'assigns the requested timesheet to @timesheet' do
        expect(assigns(:timesheet)).to eq timesheet
      end

      it 'render the :show template' do
        expect(response).to render_template :show
      end
    end

    context 'as unauthorized user' do
      before do
        sign_in normal_user
        get :show, params: { id: timesheet.id }
      end

      it 'return a 302 response' do
        expect(response).to redirect_to root_url
        expect(response.status).to eq 302
      end
    end
  end

  describe 'POST #create' do
    context 'as logged in fp_user' do
      before do
        sign_in fp_user
      end

      it 'return a 302 response' do
        post :create, params: { timesheet: timesheet_params }
        expect(response).to redirect_to timesheets_path
        expect(response.status).to eq 302
      end

      it 'save the new timesheet in the DB' do
        expect {
          post :create, params: { timesheet: timesheet_params }
        }.to change(Timesheet, :count).by(1)
      end
    end
  end
end
