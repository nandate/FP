class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :timesheet
  validates :user, presence: true
  validates :timesheet, presence: true
  has_one :approved_ticket
  validate :validate_duplicate_request

  private

  def validate_duplicate_request
    if user.applied_timesheets.where(start_time: timesheet.start_time).any?
      errors.add(:base, "すでに予約申請中です。")
    end
  end
end
