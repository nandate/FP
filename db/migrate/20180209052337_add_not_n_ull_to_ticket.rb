class AddNotNUllToTicket < ActiveRecord::Migration[5.1]
  def change
    change_column_null :tickets, :status, false
  end
end
