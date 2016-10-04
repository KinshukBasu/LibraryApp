module Record

  def getUpComingBookings
    userID = get_correct_uid
     @booking = Booking.where("userid = ? AND intime >= ? AND booking_status <>'cancelled'",userID, DateTime.current)
  end

  def getPastBookings
    userID = get_correct_uid
    @booking = Booking.where("userid = ? AND intime < ? AND booking_status <>'cancelled'",userID,DateTime.current)
  end

  def getOngoingBookings
    userID = get_correct_uid
    @booking = Booking.where("userid = ? AND intime < ?",userID,DateTime.current)
  end

  def getDeletedBookings
    userID = get_correct_uid
    @booking = Deletedbooking.where("userid = ? ",userID)
  end

  def get_correct_uid
    if session[:user].key?("historyuserid")
      return session[:user]['historyuserid']
    else
      return session[:user]['id']
      end
  end
end