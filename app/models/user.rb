class User < ApplicationRecord
  has_secure_password

  validates :name,:address,:email, presence: true
  validates :password_digest, presence: true
  validates :email, uniqueness:  true

  enum role: [:super, :admin, :normal]
end
