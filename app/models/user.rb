class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: {user: 0, fp: 1}
  has_many :timesheets
  has_many :tickets

  def waiting_tickets
    tickets.waiting.includes(:timesheet)
  end

  def approved_tickets
    tickets.approved.includes(:timesheet)
  end

  def waiting_reservations
    waiting_tickets.map(&:timesheet)
  end

  def approved_reservations
    approved_tickets.map(&:timesheet)
  end

end
