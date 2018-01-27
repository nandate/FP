class Timesheet < ApplicationRecord
  belongs_to :user
  validates :start_time, presence: true

  enum status: { free: 0, booked: 1}
end
