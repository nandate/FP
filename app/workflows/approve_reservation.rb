class ApproveReservation
  attr_reader :timesheet, :success

  def initialize(user:, timesheet: )
    @timesheet = timesheet
    @success = false
  end

  def run
    Ticket.transaction do
      ticket = timesheet.ticket
      return unless ticket.waiting?
      ticket.update(status: :approved)
      self.success = ticket.valid?
      success
    end
  end

end
