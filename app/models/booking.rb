class Booking < ApplicationRecord
  validates :intime, uniqueness: { scope: :userid
 }
# Validation criteria and room availibility search
#First this gets the upcoming bookings and then returns available time slots accordingly.
# Comments are added on top of each method in Bookinghelperservice class
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

