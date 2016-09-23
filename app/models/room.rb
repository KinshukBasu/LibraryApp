class Room < ApplicationRecord


  validates :location, :presence => true
  validates :size, :presence => true
end
