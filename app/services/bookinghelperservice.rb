
class Bookinghelperservice

  @slot_to_int={"00"=>0,"02"=>1,"04"=>2,"06"=>3,"08"=>4,"10"=>5,"12"=>6,"14"=>7,"16"=>8,"18"=>9,"20"=>10,"22"=>11}

  def self.get_current_bookings(criteria_params)
    Booking.joins("Inner join rooms r on r.id=room_no and r.is_existing='t'").where("(r.location=? or ? ='')
 and (r.size=? or ? =0)
 and(to_char(intime,'HH24' ) =? or ? ='')
and (to_char(intime,'YYYY-MM-DD') =? or ? ='')
and (intime  >?)
and (booking_status =?)
",criteria_params[:location],criteria_params[:location],criteria_params[:size],criteria_params[:size], criteria_params[:time],criteria_params[:time], criteria_params[:date],criteria_params[:date], Time.current,'booked')
  end

  def self.initialize_hash
    date_hash=Hash.new
    @date=DateTime.now.to_date
    @no_of_rooms=Room.all.size
    (0..7).each do |d|
      room_array=Array.new(@no_of_rooms)
      (1..@no_of_rooms).each do|i|
        a= Room.find(i)
        a.initialize_array
        room_array[i-1]=a
      end
      date_hash[@date+d]=room_array
    end
    date_hash
  end

  def self.create_user_display(return_hash,criteria_params)
    return_array=Array.new
    if criteria_params[:time]!='' && criteria_params[:date] !=''
      i=0
      slot_no=@slot_to_int[criteria_params[:time]]
      room_array=return_hash[criteria_params[:date]]
      room_array.each { |room|
        if room.time_slot_array[slot_no]==1 && last_check(criteria_params,room) && date_check(criteria_params[:date],criteria_params[:time])
          return_array[i]=[criteria_params[:date],criteria_params[:time],room.id,room.location,room.size]
          i=i+1
        end
      }
    end
    if criteria_params[:time]!='' && criteria_params[:date] ==''
      @date=DateTime.now.to_date
      count=0
      slot_no=@slot_to_int[criteria_params[:time]]
      (0..7).each do |d|
        room_array=return_hash[@date+d]
        room_array.each { |room|
          if room.time_slot_array[slot_no]==1 && last_check(criteria_params,room) && date_check(@date+d,criteria_params[:time])
            return_array[count]=[@date+d,criteria_params[:time],room.id,room.location,room.size]
            count=count+1
          end
        }

      end

    end
    if criteria_params[:time]=='' && criteria_params[:date] !=''
      count=0
      room_array=return_hash[criteria_params[:date]]
      room_array.each { |room|
        @a=room
        @b=room.id
        slots=room.time_slot_array
        slots.each_with_index { |slot,i|
          if slot==1 && last_check(criteria_params,room) && date_check(criteria_params[:date],convert_int_to_slot(i))
            return_array[count]=[criteria_params[:date],convert_int_to_slot(i),room.id,room.location,room.size]
            count=count+1
          end
        }

      }

    end
    return_array

  end
  def self.last_check(criteria_params,room)

    if room.is_existing==false
      false
    elsif criteria_params[:location]!='' && room.location !=criteria_params[:location]
      false
    elsif criteria_params[:size]!='0' && room.size !=criteria_params[:size].to_i
      false
    else
      true
    end

  end

  def self.convert_int_to_slot(i)
    @slot_to_int.each do|k,v|
      if v==i
        return k
      end

    end
  end

  def self.date_check(date,time)
    if(date==Time.now.to_date)

      return  time>Time.now.strftime("%H")
    end
    return true

  end

  def self.populate_return_hash(returnValues,return_hash)
    returnValues.each do|rv|
      return_hash[rv.intime.to_date][rv.room_no-1].time_slot_array[@slot_to_int[rv.intime.strftime("%H")]]=0;
    end
    return return_hash
  end


end