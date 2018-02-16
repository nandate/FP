class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :timesheet
  validates :user, presence: true
  validates :timesheet, presence: true

  enum status: {waiting: 0 , approved: 1}
end
