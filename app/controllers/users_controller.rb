class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @timesheets = @user.timesheets.includes(:tickets)
    @tickets = @user.tickets.includes(:timesheet)
  end
end
