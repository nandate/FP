class TicketsController < ApplicationController
  before_action :load_timesheet, only: %i(create update)
  before_action :correct_user, only: %i(destroy)

  def create
    current_user.tickets.create!(timesheet: @timesheet, status: "waiting")
    redirect_to current_user, success: "予約に成功しました。"
  rescue ActiveRecord::RecordInvalid => e
    redirect_to timesheets_path, danger: "予約に失敗しました。#{e.record.errors.join(',')}"
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
