class ApprovedTicket < ApplicationRecord
  belongs_to :user
  belongs_to :timesheet
  validates :user, presence: true
  validates :timesheet, presence: true
end
