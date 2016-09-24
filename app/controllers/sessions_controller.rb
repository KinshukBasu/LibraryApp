class SessionsController < AccessController
  before_filter :signon
  def destroy

  end

  def signon
    if(params[:what] == 'logout')
      session[:user_id] = nil
      render :thankyou, notice: 'Logged Out!'
      return
    end
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to welcome_display_path
      return
    else
      render :new
      return
    end
  end

  def new

  end
end
