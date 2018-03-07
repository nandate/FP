class ApprovedTicketsController < ApplicationController
  before_action :load_timesheet
  def create
    current_user.approved_tickets.create!(timesheet: @timesheet)
    redirect_to current_user, success: "予約を承認しました。"
  rescue ActiveRecord::RecordInvalid => e
    redirect_to timesheet, danger: "予約の承認に失敗しました。#{e.record.errors.join(',')}"
  end

  def destroy
  end

  private

  def load_timesheet
    @timesheet = current_user.timesheets.find(params[:timesheet_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, danger: "Timesheetが見つかりません。"
  end
end
