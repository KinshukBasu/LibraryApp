
class User < ApplicationRecord
  has_secure_password



  validates :name,:email,:address, presence: {message: "%{attribute} cannot be blank."}
  validates :password_digest, presence: {on: :create}
  validates :password, :length => {minimum: 6, on: :create}
  validates_confirmation_of :password, { on: :create}
  validates :email, uniqueness:{message: "%{value} has already been registered."}
  validates :phoneNumber, length: {is:10}, numericality: true, allow_blank: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  enum role: [:Super, :Admin, :Normal]
end