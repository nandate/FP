class ApprovedTicket < ApplicationRecord
  validates :fp_user_id, presence: true
  validates :timesheet_id, presence: true
end
