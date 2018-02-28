class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_timesheet, only: %i(create update)
  before_action :correct_user, only: %i(destroy)

  def create
    create_reservation = CreateReservation.new(
      user: current_user,
      timesheet: @timesheet
    )
    create_reservation.run!
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
    @ticket.destroy
    redirect_to current_user, success: "予約をキャンセルしました。"
  end

  private

  def load_timesheet
    @timesheet = Timesheet.find(params[:timesheet_id])
  end

  def correct_user
    @ticket = current_user.tickets.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, danger: "Ticketが見つかりませんでした。"
  end
end
