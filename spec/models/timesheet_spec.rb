require 'rails_helper'

RSpec.describe Timesheet, type: :model do
  let(:timesheet) { build(:timesheet) }

  it { expect(timesheet).to be_valid }

  describe 'association test' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validation test' do
    it 'is invalid with a past time' do
      timesheet = build(:timesheet, start_time: Time.zone.local(2000))
      expect(timesheet).not_to be_valid
      expect(timesheet.errors[:start_time]).to include(':過去の日付は使用できません。')
    end
  end
end
