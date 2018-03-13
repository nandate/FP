require 'rails_helper'

RSpec.describe Timesheet, type: :model do
  let(:timesheet) { build(:timesheet) }

  it { expect(timesheet).to be_valid }

  describe 'association test' do
    it { is_expected.to belong_to(:user) }
  end
end
