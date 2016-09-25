module Record
  def getUpComingBookings
    userID = session[:user_id]
    time = (Time.now)
    @booking = Booking.where('userid = ? AND (intime >= ?)',userID,time)
  end

  def getPastBookings
    userID = session[:user_id]
    time = (Time.now)
    @booking = Booking.where('userid = ? AND (outtime < ?)',userID,time)
  end

  def getOngoingBookings
    userID = session[:user_id]
    time = (Time.now)
    @booking = Booking.where('userid = ? AND (intime < ?) AND (outtime >= ?)',userID,time,time)
  end
end