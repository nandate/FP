require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  let(:user) { create(:user, name: "a", email: "a@example.com") }
  let(:timesheet) { create(:timesheet) }

  describe 'POST #create' do
    before { sign_in user }

    let(:params) do
      {
        ticket: {
          user_id: user.id,
          timesheet_id: timesheet.id
        }
      }
    end
    subject { post :create, params: params }

    context 'create success' do
      it { expect(subject.status).to eq 302 }
      it { expect { subject }.to change(Ticket, :count).by(1) }
      it { expect(subject).to redirect_to current_user }
    end
  end
end
