require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  let(:user) { create(:user, name: "a", email: "a@example.com") }
  let(:timesheet) { create(:timesheet) }

  describe 'POST #create' do
    before { sign_in user }

    let(:params) do
      {
        timesheet_id: timesheet.id,
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
      it { expect(subject).to redirect_to user }
    end
  end

  describe 'DELETE #destory' do
    let(:ticket) { create(:ticket, user: user, timesheet: timesheet) }
    let(:other_user) { create(:user, name: "b", email: "b@example.com") }
    let(:params) do
      {
        timesheet_id: timesheet.id,
        id: ticket.id
      }
    end
    subject { delete :destroy, params: params }

    context 'an authorized user' do
      before { sign_in user }

      it { expect(subject.status).to eq 302 }
      it { expect { subject }.to change(Ticket, :count).by(-1) }
      it { expect(subject).to redirect_to user }
    end

    context 'an unauthorized user' do
      before { sign_in other_user }

      it { expect { subject }.not_to change(Ticket, :count) }
      it { expect(subject).to redirect_to root_url }
    end
  end
end
