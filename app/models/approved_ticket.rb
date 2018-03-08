class ApprovedTicket < ApplicationRecord
  belongs_to :timesheet
  belongs_to :ticket
  validates :timesheet, presence: true
  validates :ticket, presence: true
end
