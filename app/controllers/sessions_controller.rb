class SessionsController < AccessController
  before_filter :signon
  def destroy

  end

  def signon
    if(params[:what] == 'logout')
      session[:user] = nil
      render :thankyou, notice: 'Logged Out!'
      return
    end
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user] = user
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
