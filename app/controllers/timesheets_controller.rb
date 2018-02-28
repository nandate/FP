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
      redirect_to timesheets_path, flash: { success: "Timesheetを作成しました。" }
    else
      render :new
    end
  end

  def destroy
    @timesheet.destroy!
    redirect_to request.referer, flash: { success: "Timesheetの削除に成功しました。" }
  rescue ActiveRecord::RecordNotDestroyed
    redirect_to root_url, flash: { danger: "Timesheetの削除に失敗しました。" }
  end

  private

  def timesheet_params
    params.require(:timesheet).permit(:start_time)
  end

  def fp_user
    redirect_to root_url unless current_user.fp?
  end

  def set_timesheet
    @timesheet = current_user.timesheets.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, flash: { danger: "Timesheetが見つかりません。" }
  end
end
