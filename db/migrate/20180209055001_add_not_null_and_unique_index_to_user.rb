class AddNotNullAndUniqueIndexToUser < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :name, false
    add_index :users, [:name], unique: true
  end
end
