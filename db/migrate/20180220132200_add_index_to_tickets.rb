class AddIndexToTickets < ActiveRecord::Migration[5.1]
  def change
    add_index :tickets, [:user_id, :timesheet_id], unique: true
  end
end
