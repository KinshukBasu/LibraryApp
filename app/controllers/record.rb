module Record
  def getUpComingBookings
    userID = session[:user_id]
    time = (Time.now)
    @booking = Booking.where('user_id = ? AND (checkin >= ?)',userID,time)
  end

  def getPastBookings
    userID = session[:user_id]
    time = (Time.now)
    @booking = Booking.where('user_id = ? AND (checkin < ?)',userID,time)
  end

end