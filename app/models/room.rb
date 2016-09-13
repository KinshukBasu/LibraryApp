class Room < ApplicationRecord

  validates :room_no, :presence => true
  validates :location, :presence => true
  validates :size, :presence => true
end
