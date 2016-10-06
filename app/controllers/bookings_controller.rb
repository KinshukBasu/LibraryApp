class BookingsController < AccessController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]


  # GET /bookings
  # GET /bookings.json
  def index

    @upcomingbooking = Booking.where("intime >= ?",DateTime.current)
    @pastbooking = Booking.where("intime < ?",DateTime.current)
    @deletedbooking = Deletedbooking.all

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

    if((session[:user]['role']) != "Normal")
      @condition=@booking.save(validate: false)
    else
      @condition=@booking.save
      end

    respond_to do |format|
      if @condition
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
      #  format.html { render :new }
        format.html { redirect_to static_search_path(:bookinguserid => @userid ), notice:'You can only book one room at one time'  }
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
    session[:user]['bookinguserid']= params[:bookinguserid] if params.key? "bookinguserid"
    render :search
  end

  def booking_history
    session[:user]['historyuserid'] = params[:historyuserid] if params.key? "historyuserid"
  end

  def room_history
    roomid = params[:historyroomid] if params.key? "historyroomid"
    @upcomingbooking = Booking.where("room_no = ? AND intime >= ?",roomid,DateTime.current)
    @pastbooking = Booking.where("room_no = ? AND intime < ?",roomid,DateTime.current)
    @deletedbooking = Deletedbooking.where("room_no = ?",roomid)
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
