class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.string :description
      t.integer :status
      t.datetime :timer
      t.datetime :remaining_time

      t.timestamps
    end
  end
end
