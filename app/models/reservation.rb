class Reservation
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def waiting_tickets
    @tickets = user.tickets_awaiting_approval
  end

  def approved_tickets
    @tickets = user.approved_tickets
  end


  def waiting_reservations
    waiting_tickets.map(&:timesheet).uniq.sort_by(&:start_time)
  end

  def approved_reservations
    approved_tickets.map(&:timesheet).uniq.sort_by(&:start_time)
  end

end
