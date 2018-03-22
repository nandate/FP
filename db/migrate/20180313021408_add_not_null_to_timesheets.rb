class AddNotNullToTimesheets < ActiveRecord::Migration[5.1]
  def change
    change_column_null :timesheets, :start_time, false
  end
end
