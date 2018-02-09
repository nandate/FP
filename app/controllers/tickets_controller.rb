class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_timesheet, only: [:create, :update]

  def create
    return unless @timesheet.ticket.nil?
    create_reservation = CreateReservation.new(
      user: current_user, timesheet: @timesheet)
    if create_reservation.run
      flash[:success] = "正常に予約できました。"
      redirect_to current_user
    else
      flash[:danger] = "正常に予約ができませんでした。"
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
