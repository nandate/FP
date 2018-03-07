class TicketsController < ApplicationController
  before_action :load_timesheet, only: %i(create update)
  before_action :correct_user, only: %i(destroy)
  before_action :permit_only_normal_user!

  def create
    current_user.tickets.create!(timesheet: @timesheet, status: "waiting")
    redirect_to current_user, success: "予約に成功しました。"
  rescue ActiveRecord::RecordInvalid => e
    redirect_to timesheets_path, danger: "予約に失敗しました。#{e.record.errors.join(',')}"
  end

  def update
    approve_reservation = ApproveReservation.new(timesheet: @timesheet)
    if approve_reservation.run
      redirect_to current_user, success: "予約を承認しました。"
    else
      redirect_to current_user, danger: "予約の承認に失敗しました。"
    end
  end

  def destroy
    @ticket.destroy!
    redirect_to current_user, success: "予約をキャンセルしました。"
  rescue ActiveRecord::RecordNotDestroyed
    redirect_to root_url, danger: "予約のキャンセルに失敗しました。"
  end

  private

  def load_timesheet
    @timesheet = Timesheet.find(params[:timesheet_id])
  end

  def permit_only_normal_user!
    redirect_to root_url unless current_user.user?
  end

  def correct_user
    @ticket = current_user.tickets.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, danger: "Ticketが見つかりませんでした。"
  end
end
