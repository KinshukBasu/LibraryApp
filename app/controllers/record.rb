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
  def upcoming_room_boookings(id)
    @booking=Booking.where("room_no = ? AND intime > ?",id,DateTime.current)
    if @booking.size>0
      @msg="Bookings exist for this room in the future. Are you sure you want to go ahead"
    else
      @msg="Are you sure you want to go ahead?"
    end
  end

  def get_correct_uid
    if session[:user].key?("historyuserid")
      return session[:user]['historyuserid']
    else
      return session[:user]['id']
      end
  end
end