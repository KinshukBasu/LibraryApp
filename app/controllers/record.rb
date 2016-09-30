module Record

  def getUpComingBookings
    userID = session[:user]['id']
    @booking = Booking.where("userid = ? AND intime >= datetime('now','localtime')",userID)
  end

  def getPastBookings
    userID = session[:user]['id']
    @booking = Booking.where("userid = ? AND intime < datetime('now','localtime')",userID)
  end

  def getOngoingBookings
    userID = session[:user]['id']
    @booking = Booking.where("userid = ? AND intime < datetime('now','localtime')" ,userID)
  end
end