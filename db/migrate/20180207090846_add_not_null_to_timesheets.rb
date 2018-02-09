class AddNotNullToTimesheets < ActiveRecord::Migration[5.1]
  def change
    change_column_null :timesheets, :start_time, false
    change_column_null :timesheets, :status, false
  end
end
