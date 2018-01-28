class RemoveStatusFromTimesheet < ActiveRecord::Migration[5.1]
  def change
    remove_column :timesheets, :status, :integer
  end
end
