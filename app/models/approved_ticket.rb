class ApprovedTicket < ApplicationRecord
  belongs_to :timesheet
  belongs_to :ticket
  validates :timesheet, presence: true, uniqueness: true
  validates :ticket, presence: true, uniqueness: true
end
