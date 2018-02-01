class TicketsController < ApplicationController
  before_action :authenticate_user!

  def create
    timesheet = Timesheet.find(params[:timesheet_id])
    return unless timesheet.ticket.nil?
    workflow = CreateReservation.new(
      user: current_user, timesheet: timesheet)
    workflow.run
    if workflow.success
      flash[:success] = "予約しました。"
      redirect_to current_user
    else
      redirect_to timesheets_path
    end
  end

  def update
    timesheet = Timesheet.find(params[:timesheet_id])
    workflow = ApproveReservation.new(timesheet: timesheet)
    workflow.run
    if workflow.success
      flash[:success] = "予約を承認しました。"
      redirect_to current_user
    else
      redirect_to root_path
    end
  end

end
