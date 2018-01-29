class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: {user: 0, fp: 1}
  has_many :timesheets
  has_many :tickets

  def tickets_awaiting_approval
    tickets.waiting.all.to_a
  end

  def approved_tickets
    tickets.approved.all.to_a
  end

end
