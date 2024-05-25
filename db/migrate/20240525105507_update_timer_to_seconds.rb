class UpdateTimerToSeconds < ActiveRecord::Migration[7.1]
  def change
    remove_columns :todos, :timer, :remaining_time
    add_column :todos, :timer, :integer
    add_column :todos, :remaining_time, :integer
  end
end
