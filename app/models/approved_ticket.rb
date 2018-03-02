class ApprovedTicket < ApplicationRecord
  belongs_to :user
  belongs_to :timesheet
  validates :fp_user_id, presence: true
  validates :timesheet_id, presence: true
end
