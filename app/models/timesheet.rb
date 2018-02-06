class Timesheet < ApplicationRecord
  belongs_to :user
  has_one :ticket
  validates :start_time, presence: true
  validates :user, presence: true
  validate :validate_past, if: :past_time?
  validate :validate_start_time

  private
    def past_time?
      start_time < Time.zone.now
    end

    def validate_past
      errors.add(:start_time, ":過去の日付は使用できません。")
    end

    def validate_start_time
      case start_time.wday
      when 0
        errors.add(:start_time, ":日曜日は作成できません。")
      when 6
        if start_time.hour < 11 || start_time.hour > 15
          errors.add(:start_time, ":土曜日は11:00~15:00のみ作成できます。")
        end
      else
        if start_time.hour < 10 || start_time.hour > 18
          errors.add(:start_time, "平日は10:00~18:00のみ作成できます。")
        end
      end
    end

end
