class TimesheetsController < ApplicationController
  before_action :fp_user, only: %i(new create destroy)
  before_action :set_timesheet, only: :destroy

  def index
    @timesheets = Timesheet.includes(:user).all
  end

  def new
    @timesheet = current_user.timesheets.build
  end

  def create
    @timesheet = current_user.timesheets.build(timesheet_params)
    if @timesheet.save
      redirect_to timesheets_path
    else
      render :new
    end
  end

  def destroy
    @timesheet.destroy
    redirect_to request.referer, success: "Timesheetの削除に成功しました。"
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, danger: "Timesheetが見つかりません。"
  end

  private

  def timesheet_params
    params.require(:timesheet).permit(:start_time)
  end

  def fp_user
    redirect_to root_url unless current_user.fp?
  end

  def set_timesheet
    @timesheet = current_user.timesheet.find(params[:id])
  end
end
