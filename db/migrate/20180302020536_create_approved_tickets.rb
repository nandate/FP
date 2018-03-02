class CreateApprovedTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :approved_tickets do |t|
      t.integer :fp_user_id, null: false
      t.integer :timesheet_id, null: false

      t.timestamps
    end
    add_index :approved_tickets, :fp_user_id
    add_index :approved_tickets, :timesheet_id
    add_index :approved_tickets, [:fp_user_id, :timesheet_id], unique: true
  end
end
