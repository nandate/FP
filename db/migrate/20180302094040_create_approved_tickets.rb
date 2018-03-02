class CreateApprovedTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :approved_tickets do |t|
      t.references :user, foreign_key: true
      t.references :timesheet, foreign_key: true

      t.timestamps
    end
    add_index :approved_tickets, [:user_id, :timesheet_id], unique: true
  end
end
