class TimesheetsController < ApplicationController
  before_action :fp_user, only: [:new, :create]
  before_action :correct_user, only: :destroy

  def index
    @timesheets = Timesheet.all
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

  private
    def timesheet_params
      params.require(:timesheet).permit(:start_time)
    end

    def fp_user
      redirect_to root_url unless current_user.fp?
    end

    def correct_user
      @timesheet = current_user.timesheets.find_by(id: params[:id])
      redirect_to root_url if @timesheet.nil?
    end

end
