class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  has_secure_password
  has_secure_token :api_key, length: 32
end
