class UsersController < AccessController
  before_action :set_user, only: [:show, :edit, :destroy]
  before_action :set_user_update, only: [:update]

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

  #Search for user based on certain criteria from admin homepage
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
#Make user into an admin
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
        redirect_to welcome_display_path, notice: 'User was successfully updated.'
        return
      else

        message = ''
        @user.errors.messages.each do|k,n|
          message = message.concat(n[0].to_s).concat('<br>')
        end

        message.chomp('<br>')
        render :json =>{:message => message}
        return
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  # Delete user and also take care of his bookings
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
# Delete future bookings for a deleted user.
  def delete_user_bookings(id)
    Booking.where("userid = ? AND intime > ?",id,DateTime.current).destroy_all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_id(params[:id])
    end

  def set_user_update
    @user = User.find_by_id(params[:user][:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation, :role)
    end

#Define safe parameters while updating a user
  def user_edit_params

      params.require(:user).permit(:name, :address, :phoneNumber, :password, :password_confirmation,:allow_multiple)
  end
end
