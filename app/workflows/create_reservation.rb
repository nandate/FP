class CreateReservation
  attr_accessor :user, :timesheet, :success

  def initialize(user:, timesheet: )
    @user = user
    @timesheet = timesheet
    @success = false
  end

  def run
    Ticket.transaction do
      ticket = Ticket.create(user: user, timesheet: timesheet, status: "waiting")
      self.success = ticket.valid?
      success
    end
  end

end
