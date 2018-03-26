class Timesheet < ApplicationRecord
  belongs_to :user
  has_many :tickets
  has_one :approved_ticket
  validates :start_time, presence: true
  validates :user, presence: true
  validate :validate_past
  validate :validate_start_time
  validate :validate_time_step
  validate :validate_double_book
  scope :order_by_start_time, -> { order(:start_time) }

  TIMES = ["10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00",
           "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30",
           "17:00", "17:30"].freeze

  private

  def validate_past
    if start_time < Time.zone.now
      errors.add(:start_time, ":過去の日付は使用できません。")
    end
  end

  def validate_time_step
    if TIMES.index(start_time.strftime("%H:%M")).nil?
      errors.add(:start_time, ":この時刻では作成できません。")
    end
  end

  def validate_double_book
    timesheet = Timesheet.where(user_id: user_id).where(start_time: start_time)
    if timesheet.any?
      errors.add(:start_time, ":この時間にはすでに予約が作成されています。")
    end
  end

  def validate_start_time
    case start_time.wday
    when 0
      errors.add(:start_time, ":日曜日は作成できません。")
    when 6
      if start_time.hour < 11 || start_time.hour > 14
        errors.add(:start_time, ":土曜日は11:00~15:00のみ作成できます。")
      end
    else
      if start_time.hour < 10 || start_time.hour > 17
        errors.add(:start_time, "平日は10:00~18:00のみ作成できます。")
      end
    end
  end
end
