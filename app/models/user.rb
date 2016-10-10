
class User < ApplicationRecord
  has_secure_password

#User validation based on various criteria

  validates :name,:email,:address, presence: {message: '%{attribute} cannot be blank.'}
  #validates :password_digest, presence: {on: :create, message: 'Password should match.'}
  #validates :password_digest, presence: {on: :update, message: 'Password should match.', if: "!password.blank?"}
  validates :password, :length => {minimum: 6, on: :create, message: 'Password size should be more than 5 characters.'}
  validates :password, :length => {minimum: 6, on: :update, message: 'Password size should be more than 5 characters.', if: "!password.blank?"}
  validates_confirmation_of :password, :message => 'Password should match.', on: :create, if: "!password.blank?"
  validates_confirmation_of :password, :message => 'Password should match.',  on: :update, if: "!password.blank?"
  validates :email, uniqueness:{message: '%{value} has already been registered.'}
  validates :phoneNumber, length: {is:10, message: 'Please check the number.'}, numericality: {message: 'Please check the number.'}, allow_blank: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'Email format is incorrect.'}

  enum role: [:Super, :Admin, :Normal]
end