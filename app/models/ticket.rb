class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :timesheet

  enum status: { waiting: 0 , approved: 1}
end
