class CreateReservation
  attr_reader :user, :timesheet

  def initialize(user:, timesheet: )
    @user = user
    @timesheet = timesheet
  end

  def run
    Ticket.transaction do
      ticket = Ticket.create!(user: user, timesheet: timesheet, status: "waiting")
    end
  end

end