class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_timesheet, only: [:create, :update]

  def create
    return unless @timesheet.ticket.nil?
    workflow = CreateReservation.new(
      user: current_user, timesheet: @timesheet)
    workflow.run
    if workflow.success
      redirect_to current_user
    else
      redirect_to timesheets_path
    end
  end

  def update
    workflow = ApproveReservation.new(timesheet: timesheet)
    workflow.run
    if workflow.success
      flash[:success] = "予約を承認しました。"
      redirect_to current_user
    else
      redirect_to root_path
    end
  end

  private
    def load_timesheet
      @timesheet = Timesheet.find(params[:timesheet_id])
    end

end
