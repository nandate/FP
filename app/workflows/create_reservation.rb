class CreateReservation
  attr_reader :user, :timesheet

  def initialize(user:, timesheet:)
    @user = user
    @timesheet = timesheet
  end

  def run!
    Ticket.transaction do
      user.tickets.create!(timesheet: timesheet, status: "waiting")
    end
  end
end
