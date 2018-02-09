class ApproveReservation
  attr_reader :timesheet

  def initialize(timesheet: )
    @timesheet = timesheet
  end

  def run
    Ticket.transaction do
      ticket = timesheet.ticket
      return unless ticket.waiting?
      ticket.update(status: :approved)
    end
  end

end
