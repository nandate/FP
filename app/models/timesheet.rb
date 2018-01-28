class Timesheet < ApplicationRecord
  belongs_to :user
  validates :start_time, presence: true
  validate :start_time_past?, :start_time_valid?

  enum status: { free: 0, booked: 1}

  def start_time_past?
    errors.add(:start_time, ":過去の日付は使用できません。") if start_time < Time.now
  end

  def start_time_valid?
    case start_time.wday
    when 0
      errors.add(:start_time,":日曜日は作成できません。")
    when 6
      errors.add(:start_time, ":土曜日は11:00~15:00のみ作成できます。") if start_time.hour < 11 || start_time.hour > 15
    else
      errors.add(:start_time, "平日は10:00~18:00のみ作成できます。") if start_time.hour < 10 || start_time.hour > 18
    end
  end

end
