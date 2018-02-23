class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_timesheet, only: [:create, :update]
  before_action :correct_user, only: [:destroy]

  def create
    #return unless @timesheet.ticket.nil?
    create_reservation = CreateReservation.new(
      user: current_user,
      timesheet: @timesheet
    )
    create_reservation.run!
    flash[:success] = "予約に成功しました。"
    redirect_to current_user
  rescue ActiveRecord::RecordInvalid => e
    flash[:danger] = "予約に失敗しました。#{e.record.errors}"
    redirect_to timesheets_path
  end

  def update
    approve_reservation = ApproveReservation.new(timesheet: @timesheet)
    if approve_reservation.run
      flash[:success] = "予約を承認しました。"
      redirect_to current_user
    else
      flash[:danger] = "予約の承認に失敗しました。"
      redirect_to current_user
    end
  end

  def destroy
    @ticket.destroy
    flash[:success] = "予約をキャンセルしました。"
    redirect_to current_user
  end

  private
    def load_timesheet
      @timesheet = Timesheet.find(params[:timesheet_id])
    end

    def correct_user
      @ticket = current_user.tickets.find(params[:ticket_id])
      redirect_to root_url if @ticket.nil?
    end

end
