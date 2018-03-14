require 'rails_helper'

RSpec.describe TimesheetsController, type: :controller do
  let(:user) { create(:user, role: 'fp') }
  let(:timesheet) { create(:timesheet) }
  let(:timesheets) { Timesheet.all.order_by_start_time }

  describe 'GET #index' do
    context 'as logged in' do
      before do
        sign_in user
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
end
