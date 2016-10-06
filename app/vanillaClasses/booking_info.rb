class BookingInfo

  attr_accessor :roomNumber, :name, :duration, :date, :location, :email, :userEmail, :startTime

  def initialize
    @name = ''
    @userEmail = ''
    @date = ''
    @roomNumber = ''
    @location = ''
    @duration = ''
    @email = ''
    @startTime = ''
  end

  end