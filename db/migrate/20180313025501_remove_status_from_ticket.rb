class RemoveStatusFromTicket < ActiveRecord::Migration[5.1]
  def change
    remove_column :tickets, :status, :integer
  end
end
