# == Schema Information
#
# Table name: todos
#
#  id             :bigint           not null, primary key
#  description    :string
#  remaining_time :integer
#  status         :integer
#  timer          :integer
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#
# Indexes
#
#  index_todos_on_user_id  (user_id)
#
class Todo < ApplicationRecord
  belongs_to :user, foreign_key: :user_id, inverse_of: :todos
  enum :status, [ :todo, :in_progress,:done ], default: :todo

end
