class Room < ApplicationRecord

  has_many :bookings

  validates :room_number, :address, :isAvailable,
            presence: true
end
