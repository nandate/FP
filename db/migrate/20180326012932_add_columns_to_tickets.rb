class AddColumnsToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :message, :string, :null => false
    add_column :tickets, :charge, :integer, :null => false
  end
end
