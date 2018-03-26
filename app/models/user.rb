class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { user: 0, fp: 1 }
  has_many :timesheets
  has_many :tickets
  has_many :applied_timesheets, through: :tickets, source: 'timesheet'
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :email, length: { maximum: 255 }
  validates :role, presence: true
end
