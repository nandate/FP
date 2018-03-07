class CreateApprovedTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :approved_tickets do |t|
      t.references :timesheet, index: { unique: true }, foreign_key: true

      t.timestamps
    end
  end
end
