module Record

  def getUpComingBookings
    userID = session[:user]['id']
     @booking = Booking.where("userid = ? AND intime >= ? AND booking_status <>'cancelled'",userID, DateTime.current)
  end

  def getPastBookings
    userID = session[:user]['id']
    @booking = Booking.where("userid = ? AND intime < ? AND booking_status <>'cancelled'",userID,DateTime.current)
  end

  def getOngoingBookings
    userID = session[:user]['id']
    @booking = Booking.where("userid = ? AND intime < ?",userID,DateTime.current)
  end

  def getDeletedBookings
    userID = session[:user]['id']
    @booking = Deletedbooking.where("userid = ? ",userID)
  end
end