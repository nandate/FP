require 'rails_helper'

RSpec.describe ApprovedTicketsController, type: :controller do
  let(:fp_user) { create(:fp_user) }
  let(:other_fp_user) { create(:other_fp_user) }
  let(:timesheet) { create(:timesheet, user: fp_user) }
  let(:ticket) { create(:ticket, timesheet: timesheet) }

  describe 'POST #create' do
    let(:params) do
      {
        timesheet_id: timesheet.id,
        ticket_id: ticket.id,
        approved_ticket: {
          timesheet_id: timesheet.id,
          ticket_id: ticket.id
        }
      }
    end
    subject { post :create, params: params }

    context 'an authorized user' do
      before { sign_in fp_user }

      context 'create success' do
        it { expect(subject.status).to eq 302 }
        it { expect(subject).to redirect_to fp_user }
        it { expect { subject }.to change(ApprovedTicket, :count).by(1) }
      end
    end

    context 'an unauthorized user ' do
      before { sign_in other_fp_user }

      context 'create failed' do
        it { expect { subject }.not_to change(ApprovedTicket, :count) }
        it { expect(subject).to redirect_to root_url }
        it { expect(subject.status).to eq 302 }
      end
    end
  end
end
