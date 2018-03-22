require 'rails_helper'

RSpec.describe Timesheet, type: :model do
  let(:timesheet) { build(:timesheet) }
  let(:fp_user) { create(:fp_user) }

  it { expect(timesheet).to be_valid }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:user) }
  end

  describe 'association test' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validation test' do
    it 'is invalid with a past time' do
      timesheet = build(:timesheet, start_time: Time.zone.local(2000))
      expect(timesheet).not_to be_valid
      expect(timesheet.errors[:start_time]).to include(':過去の日付は使用できません。')
    end

    it 'is invalid with a time width is not 30 minutes' do
      timesheet = build(:timesheet, start_time: Time.zone.local(2019, 12, 6, 12, 13, 0))
      expect(timesheet).not_to be_valid
      expect(timesheet.errors[:start_time]).to include(':この時刻では作成できません。')
    end

    it 'is invalid with a reservate in Sunday' do
      timesheet = build(:timesheet, start_time: Time.zone.local(2019, 12, 8, 12, 0, 0))
      expect(timesheet).not_to be_valid
      expect(timesheet.errors[:start_time]).to include(':日曜日は作成できません。')
    end

    context 'validation in Saturday' do
      it 'is invalid with a reservate at 15:00 in Saturday' do
        timesheet = build(:timesheet, start_time: Time.zone.local(2019, 12, 7, 15, 0, 0))
        expect(timesheet).not_to be_valid
        expect(timesheet.errors[:start_time]).to include(':土曜日は11:00~15:00のみ作成できます。')
      end

      it 'is valid with a reservate at 14:30 in Saturday' do
        timesheet = build(:timesheet, start_time: Time.zone.local(2019, 12, 7, 14, 30, 0))
        expect(timesheet).to be_valid
      end

      it 'is valid with a reservate at 11:00 in Saturday' do
        timesheet = build(:timesheet, start_time: Time.zone.local(2019, 12, 7, 11, 0, 0))
        expect(timesheet).to be_valid
      end
    end

    context 'validation in weekday' do
      it 'is invalid with a reservate at 18:00 in Friday' do
        timesheet = build(:timesheet, start_time: Time.zone.local(2019, 12, 6, 18, 0, 0))
        expect(timesheet).not_to be_valid
        expect(timesheet.errors[:start_time]).to include('平日は10:00~18:00のみ作成できます。')
      end

      it 'is valid with a reservate at 17:30 in Friday' do
        timesheet = build(:timesheet, start_time: Time.zone.local(2019, 12, 6, 17, 30, 0))
        expect(timesheet).to be_valid
      end

      it 'is valid with a reservate at 10:00 in Friday' do
        timesheet = build(:timesheet, start_time: Time.zone.local(2019, 12, 6, 10, 0, 0))
        expect(timesheet).to be_valid
      end
    end

    context 'validation same time' do
      let(:timesheet2) { create(:timesheet, user: fp_user) }
      it 'is invalid with a same user in same time' do
        expect(timesheet2).not_to be_valid
        expect(timesheet2.errors[:start_time]).to include(':この時間にはすでに予約が作成されています。')
      end
    end
  end
end