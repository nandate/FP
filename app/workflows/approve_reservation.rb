class ApproveReservation
  attr_reader :timesheet

  def initialize(timesheet:)
    @timesheet = timesheet
  end

  def run
    ticket = timesheet.ticket
    return unless ticket.waiting?
    ticket.approved!
  end

end
