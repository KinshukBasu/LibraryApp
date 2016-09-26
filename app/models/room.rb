class Room < ApplicationRecord

  attr_accessor :time_slot_array
  def initialize_array
  @time_slot_array=[1,1,1,1,1,1,1,1,1,1,1,1]
  end
  validates :location, :presence => true
  validates :size, :presence => true
  attr_accessor :is_existing
end
