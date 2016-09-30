class User < ApplicationRecord
  has_secure_password

  validates :name,:email, presence: true
  validates :password_digest, presence: true
  validates :email, uniqueness:  true

  enum role: [:Super, :Admin, :Normal]
end
