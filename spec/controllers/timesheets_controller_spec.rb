require 'rails_helper'

RSpec.describe TimesheetsController, type: :controller do
  let(:fp_user) { create(:fp_user) }
  let(:other_fp_user) { create(:fp_user, name: "fp2", email: "fp2@explame.com") }
  let(:normal_user) { create(:user) }
  let(:timesheet) { create(:timesheet, user: fp_user) }
  let(:timesheet_params) { attributes_for(:timesheet) }
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
        expect(response).to redirect_to new_user_session_path
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
    subject { post :create, params: { timesheet: timesheet_params } }
    context 'as logged in fp_user' do
      before { sign_in fp_user }

      it { expect(subject).to redirect_to timesheets_path }
      it { expect(subject.status).to eq 302 }
      it { expect { subject }.to change(Timesheet, :count).by(1) }
    end

    context 'as logged in normal_user' do
      before { sign_in normal_user }

      it { expect { subject }.not_to change(Timesheet, :count) }
      it { expect(subject).to redirect_to root_url }
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: timesheet.id } }
    context 'as an authorized user' do
      before { sign_in fp_user }

      it 'deletes the timesheet' do
        expect { subject }.to change(fp_user.timesheets, :count).by(-1)
      end
    end

    context 'as an unauthorized user' do
      before { sign_in other_fp_user }

      it 'does not delete the timesheet' do
        expect { subject }.not_to change(Timesheet, :count)
      end

      it 'redirect to root_url' do
        expect(subject).to redirect_to root_url
      end
    end
  end
end
