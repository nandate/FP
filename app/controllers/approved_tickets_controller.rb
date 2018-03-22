class ApprovedTicketsController < ApplicationController
  before_action :set_timesheet_and_ticket
  before_action :permit_only_fp_user!

  def create
    @timesheet.create_approved_ticket!(ticket: @ticket)
    redirect_to current_user, success: "予約を承認しました。"
  rescue ActiveRecord::RecordInvalid => e
    redirect_to timesheet, danger: "予約の承認に失敗しました。#{e.record.errors.join(',')}"
  end

  private

  def set_timesheet_and_ticket
    @timesheet = current_user.timesheets.find(params[:timesheet_id])
    @ticket = @timesheet.tickets.find(params[:ticket_id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to root_url, danger: "リソースが見つかりませんでした。#{e.record.errors.join(',')}"
  end

  def permit_only_fp_user!
    redirect_to root_url unless current_user.fp?
  end
end
