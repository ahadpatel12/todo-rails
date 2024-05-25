class Todo < ApplicationRecord
  belongs_to :user, foreign_key: :user_id, inverse_of: :todos
  enum :status, [ :todo, :in_progress,:done ], default: :todo

end
