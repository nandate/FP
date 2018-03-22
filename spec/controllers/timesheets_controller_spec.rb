require 'rails_helper'

RSpec.describe TimesheetsController, type: :controller do
  let(:fp_user) { create(:fp_user) }
  let(:other_fp_user) { create(:fp_user, name: "fp2", email: "fp2@explame.com") }
  let(:normal_user) { create(:user) }
  let(:timesheet) { create(:timesheet) }
  let(:timesheets) { Timesheet.all.order_by_start_time }

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
      before { sign_in fp_user }
      let(:timesheet_params) { attributes_for(:timesheet) }
      subject { post :create, params: timesheet_params }

      it 'create success' do
        expect(response).to redirect_to timesheets_path
        expect(response.status).to eq 302
        expect { subject }.to change(Timesheet, :count).by(1)
      end
    end

    context 'as logged in normal_user' do
      before { sign_in normal_user }
      it 'does not save the timesheet in the DB' do
        expect {
          post :create, params: { timesheet: timesheet_params }
        }.not_to change(Timesheet, :count)
      end

      it 'redirect to root_url' do
        post :create, params: { timesheet: timesheet_params }
        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'as an authorized user' do
      before { sign_in fp_user }

      it 'deletes the timesheet' do
        expect {
          delete :destroy, params: { id: timesheet.id }
        }.to change(fp_user.timesheets, :count).by(-1)
      end
    end

    context 'as an unauthorized user' do
      before { sign_in other_fp_user }

      it 'does not delete the timesheet' do
        expect {
          delete :destroy, params: { id: timesheet.id }
        }.not_to change(Timesheet, :count)
      end

      it 'redirect to root_url' do
        delete :destroy, params: { id: timesheet.id }
        expect(response).to redirect_to root_url
      end
    end
  end
end
