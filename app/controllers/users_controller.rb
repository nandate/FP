class UsersController < ApplicationController
  before_action :permit_only_correct_user!, only: %i(show)

  def show
    @timesheets = @user.timesheets.includes(:tickets, :approved_ticket)
    @tickets = @user.tickets.includes(:timesheet)
  end

  private

  def permit_only_correct_user!
    @user = User.find(params[:id])
    redirect_to root_url unless current_user == @user
  end
end
