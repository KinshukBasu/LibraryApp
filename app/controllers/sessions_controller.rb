class SessionsController < AccessController
  before_filter :signon
  def destroy

  end
# Sign-in/ Sign-out functionality defined
  def signon
    if(params[:what] == 'logout')
      session[:user] = nil
      render :thankyou, notice: 'Logged Out!'
      return
    end

    if session[:user] != nil
      redirect_to welcome_display_path
      return
    end
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user] = user
      redirect_to welcome_display_path
      return
    else

      return false;
    end
  end

  def new

  end
end
