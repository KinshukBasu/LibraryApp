module Record

  def getUpComingBookings
    userID = session[:user]['id']
     @booking = Booking.where("userid = ? AND intime >= ?",userID, DateTime.current)
  end

  def getPastBookings
    userID = session[:user]['id']
    @booking = Booking.where("userid = ? AND intime < ?",userID,DateTime.current)
  end

  def getOngoingBookings
    userID = session[:user]['id']
    @booking = Booking.where("userid = ? AND intime < ?",userID,DateTime.current)
  end
end