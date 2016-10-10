class Room < ApplicationRecord
# validation criteria and setting up of time slot array for a particular room
  attr_accessor :time_slot_array
  def initialize_array
  @time_slot_array=[1,1,1,1,1,1,1,1,1,1,1,1]
  end
  validates :location, :presence => true
  validates :size, :presence => true



end
