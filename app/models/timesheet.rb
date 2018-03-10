class Timesheet < ApplicationRecord
  belongs_to :user
  has_many :tickets
  validates :start_time, presence: true
  validates :user, presence: true
  validate :validate_past
  validate :validate_start_time
  validate :validate_double_book
  scope :waiting, -> { joins(:tickets).merge(Ticket.waiting) }
  scope :approved, -> { joins(:tickets).merge(Ticket.approved) }

  private

  def validate_past
    if start_time < Time.zone.now
      errors.add(:start_time, ":過去の日付は使用できません。")
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
