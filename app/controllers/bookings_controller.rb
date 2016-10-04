class BookingsController < AccessController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]


  # GET /bookings
  # GET /bookings.json
  def index

    @bookings=Booking.all
    @deleted=Deletedbooking.all

  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show

  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @userid=session[:user]['bookinguserid']
    @room_no=params[:room_no]
    @date=params[:date].to_date
    @t=params[:time]
    @intime = Time.new(@date.year, @date.month, @date.day,@t.to_i,0, 0)
    @booking = Booking.new({:userid=>@userid,:room_no=>@room_no,:intime=>@intime})


    respond_to do |format|
      if @booking.save
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
      #  format.html { render :new }
        format.html { redirect_to bookings_search_static_path, notice:'You can only book one room at one time'  }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @deletedbooking = Deletedbooking.new({:userid=>@booking.userid,:room_no=>@booking.room_no,:intime=>@booking.intime})
    @deletedbooking.save
    @booking.destroy
    respond_to do |format|
     # format.html { redirect_to "/bookings/booking_history/"+session[:user]['id'].to_s, notice: 'Booking was successfully destroyed.' }
      format.html { redirect_to bookingHistory_path(:historyuserid => session[:user]['historyuserid']), notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
pass_params=params
pass_params[:date]=Date.new(params[:date][:year].to_i,params[:date][:month].to_i,params[:date][:day].to_i)
@return_params= Booking.find_availiblty(pass_params)
render :new, data: pass_params
return @return_params

  end

  def search_static
    session[:user]['bookinguserid']=params[:bookinguserid]
    render :search
  end

  def booking_history
    session[:user]['historyuserid']=params[:historyuserid]
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_booking
    @booking = Booking.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def booking_params
    params.require(:booking).permit(:userid, :room_no, :intime)
  end

end
