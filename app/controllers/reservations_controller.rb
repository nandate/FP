class ReservationsController < ApplicationController

  def show
    @reservation = Reservation.new(current_user)
  end

  def create
    timesheet = Timesheet.find(params[:timesheet_id])
    return unless timesheet.ticket.nil?
    workflow = CreateReservation.new(
      user: current_user, timesheet: timesheet)
    workflow.run
    if workflow.success
      redirect_to reservation_path
    else
      redirect_to timesheets_path
    end
  end



end
