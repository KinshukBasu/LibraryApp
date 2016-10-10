class RoomsController < AccessController
  before_action :set_room, only: [:show, :edit, :update, :destroy]


  # GET /rooms which have not been deleted
  def index
   # @rooms = Room.all
    @rooms=Room.where(is_existing: true)
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  #Update is_existing =false for rooms which are to be deleted. Also take care of their booking
  #history
  def destroy
    @room = Room.find(params[:id])
    @room.update_attributes!(is_existing: false)
    delete_from_booking_history
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
      #end

    end
  end

  #Delete upcoming bookings for a rooms which is to be deleted
  def delete_from_booking_history
    Booking.where("room_no = ? AND intime > ?",params[:id],DateTime.current).destroy_all

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:room_no, :location, :size)
    end
end
