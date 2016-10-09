module Record

  def getUpComingBookings
    userID = get_correct_uid
     @booking = Booking.where("userid = ? AND intime >= ? AND booking_status <>'cancelled'",userID, DateTime.current).order(:intime)
  end

  def getPastBookings
    userID = get_correct_uid
    @booking = Booking.where("userid = ? AND intime < ? AND booking_status <>'cancelled'",userID,DateTime.current).order(intime: :desc)
  end

  def getOngoingBookings
    userID = get_correct_uid
    @booking = Booking.where("userid = ? AND intime < ?",userID,DateTime.current)
  end

  def getDeletedBookings
    userID = get_correct_uid
    @booking = Deletedbooking.where("userid = ? ",userID).order(intime: :desc)
  end
  def upcoming_room_boookings(id)
    @upbooking=Booking.where("room_no = ? AND intime > ?",id,DateTime.current)
    @currentbooking= Booking.where("room_no = ? AND intime < ? AND intime + time '02:00' > ?",id,DateTime.current,DateTime.current ).first
    if @currentbooking!= nil
      @msg="There is a current booking for this room. Are you sure you want to go ahead"
   elsif @upbooking.size>0
      @msg="Bookings exist for this room in the future. Are you sure you want to go ahead"
    else
      @msg="Are you sure you want to go ahead?"
    end
  end
  def upcoming_user_boookings(id)
    @upbooking=Booking.where("userid = ? AND intime > ?",id,DateTime.current)
    @currentbooking= Booking.where("userid = ? AND intime < ? AND intime + time '02:00' > ?",id,DateTime.current,DateTime.current ).first
    if @currentbooking!= nil
      @msg="There is a current booking for this user. Are you sure you want to go ahead"
    elsif @upbooking.size>0
      @msg="Bookings exist for this user in the future. Are you sure you want to go ahead"
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