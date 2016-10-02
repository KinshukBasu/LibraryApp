class Booking < ApplicationRecord
  validates :intime, uniqueness: { scope: :userid
 }


  @slot_to_int={"00"=>0,"02"=>1,"04"=>2,"06"=>3,"08"=>4,"10"=>5,"12"=>6,"14"=>7,"16"=>8,"18"=>9,"20"=>10,"22"=>11}

  def self.find_availiblty(criteria_params)
    return_hash=initialize_hash
 returnValues=self.joins("Inner join rooms r on r.id=room_no and r.is_existing='t'")
.where("(r.location=? or ? is Null)
 and (r.size=? or ? is Null)
 and(to_char(intime,'HH24' ) =? or ? is Null)
and (to_char(intime,'YYYY-MM-DD') =? or ? is Null)
and (intime  >?)
and (booking_status =?)
",criteria_params[:location],criteria_params[:location],criteria_params[:size],criteria_params[:size],
criteria_params[:time],criteria_params[:time], criteria_params[:date],criteria_params[:date],
Time.current,'booked')


    returnValues.each do|rv|

      return_hash[rv.intime.to_date][rv.room_no-1].time_slot_array[@slot_to_int[rv.intime.strftime("%H")]]=0;

    end
  return_array= parse(return_hash,criteria_params)
    @a=return_array
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

  def self.parse(return_hash,criteria_params)

    return_array=Array.new
if criteria_params[:time]!=nil && criteria_params[:date] !=nil
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
    if criteria_params[:time]!=nil && criteria_params[:date] ==nil
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
    if criteria_params[:time]==nil && criteria_params[:date] !=nil
      count=0
      room_array=return_hash[criteria_params[:date]]
      room_array.each { |room|
        @a=room
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
    a=room
    b=room.location
    c=room.size
    if room.is_existing==false
      false
    elsif criteria_params[:location]!=nil && room.location !=criteria_params[:location]
     false
    elsif criteria_params[:size]!=nil && room.size !=criteria_params[:size].to_i
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
    if(date==DateTime.now.to_date)
      return  time>DateTime.now.strftime("%H")
    end
    return true

  end





end

