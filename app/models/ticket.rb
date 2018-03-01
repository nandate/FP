class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :timesheet
  validates :user, presence: true
  validates :timesheet, presence: true
  validate :validate_duplicate_request
  enum status: { waiting: 0, approved: 1 }

  def validate_duplicate_request
    ticket = user.applied_timesheets.where(start_time: timesheet.start_time)
    if ticket.any?
      errors.add(:base, "すでに予約申請中です。")
    end
  end
end
