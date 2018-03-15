require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:user) { create(:user) }
  let(:fp_user) { create(:fp_user) }
  let(:timesheet) { create(:timesheet, user: fp_user) }
  let(:ticket) { build(:ticket, user: user, timesheet: timesheet) }

  it { expect(ticket).to be_valid }
end
