class User < ApplicationRecord
  validates :email, presence: true, uniqueness:true
  # has_secure_password
  has_many :todos, foreign_key: :user_id, inverse_of: :user

end
