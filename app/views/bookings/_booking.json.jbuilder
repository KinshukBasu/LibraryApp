json.extract! booking, :id, :userid, :room_no, :intime, :outtime, :created_at, :updated_at
json.url booking_url(booking, format: :json)