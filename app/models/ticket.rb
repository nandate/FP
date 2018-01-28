class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :timesheet

  enum status: { unsold: 0, waiting: 1 }
end
