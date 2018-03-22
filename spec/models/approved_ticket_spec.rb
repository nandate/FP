require 'rails_helper'

RSpec.describe ApprovedTicket, type: :model do
  let(:approved_ticket) { build(:approved_tickets) }

  it { expect(approved_ticket).to be_valid }
end
