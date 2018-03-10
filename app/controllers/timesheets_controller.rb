class TimesheetsController < ApplicationController
  before_action :permit_only_fp_user!, only: %i(new create destroy)
  before_action :set_timesheet, only: %i(destroy)

  def index
    @timesheets = Timesheet.includes(:user).all.order_by_start_time
  end

  def new
    @timesheet = current_user.timesheets.build
  end

  def create
    @timesheet = current_user.timesheets.build(timesheet_params)
    if @timesheet.save
      redirect_to timesheets_path, success: "Timesheetを作成しました。"
    else
      render :new
    end
  end

  private

  def timesheet_params
    params.require(:timesheet).permit(:start_time)
  end

  def permit_only_fp_user!
    redirect_to root_url unless current_user.fp?
  end
end
