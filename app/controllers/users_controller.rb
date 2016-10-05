class UsersController < AccessController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def user_search

    @searchParams = params

    respond_to do |format|
      format.html { redirect_to user_information_path(:name => params[:name] , :email => params[:email], :phoneNumber => params[:phoneNumber]) }
    end



  end

  def user_information
    if(session[:user]['role'] == 'Normal')
      redirect_to welcome_display_path
      return
    end
    @resultUser = User.where("role != 0")

    if (params[:name] != nil)
      @resultUser = @resultUser.where("name like :name",{:name => "%#{params[:name]}%"})
    end

    if (params[:email] != nil && params[:email] != '')
      @resultUser = @resultUser.where("email = ?",params[:email])
    end

    if (params[:phoneNumber] != nil  && params[:phoneNumber] != '')
      @resultUser = @resultUser.where("phoneNumber = ?",params[:phoneNumber])
    end
    render 'user_information', resultUser: @resultUser
  end

  def change_user_role
    @changeUser = User.find(params[:id])

    if(@changeUser.update(:role => 1))
      return true
    else
      return false
    end

  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_edit_params)
        format.html { redirect_to welcome_display_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    delete_user_bookings(@user.id)
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_user
    if(User.destroy(params[:id]))
      delete_user_bookings(params[:id])
      return true
    else
      return false
    end

  end

  def delete_user_bookings(id)
    Booking.where("userid = ? AND intime > ?",id,DateTime.current).destroy_all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation, :role)
    end

  def user_edit_params
    params.require(:user).permit(:name, :address, :phoneNumber)
  end
end
