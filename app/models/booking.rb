class Booking < ApplicationRecord
  validates :intime, uniqueness: { scope: :userid
 }

  def self.find_availiblty(criteria_params)
    return_hash=Bookinghelperservice.initialize_hash
    returnValues=Bookinghelperservice.get_current_bookings(criteria_params)
    return_hash= Bookinghelperservice.populate_return_hash(returnValues,return_hash)
    return_array=Array.new
    if(criteria_params[:date] <= Time.now.to_date+7.days && criteria_params[:date]>=Time.now.to_date)
  return_array= Bookinghelperservice.create_user_display(return_hash,criteria_params)
  end
    return_array
  end

end

