class ApprovedTicket < ApplicationRecord
  belongs_to :user
  belongs_to :timesheet
  validates :user, presence: true
  validates :timesheet, presence: true
  validate :validate_duplicate_approve

  private

  def validate_duplicate_approve
    if user.approved_timesheets.where(start_time: timesheet.start_time)
      errors.add(:base, "この時間にはすでに承認した予約があります。")
    end
  end
end
