class User < ApplicationRecord
  has_secure_password

  has_many :bookings
  validates :name,:role,
            presence: true

end
