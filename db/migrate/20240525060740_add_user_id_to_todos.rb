class AddUserIdToTodos < ActiveRecord::Migration[7.1]
  def change
    add_column :todos, :user_id, :integer
    add_index :todos, :user_id
  end
end
