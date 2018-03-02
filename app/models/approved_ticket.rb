class ApprovedTicket < ApplicationRecord
  belongs_to :user
  belongs_to :timesheet
end
