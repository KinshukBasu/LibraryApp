class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :signon

  private

  def signon
   @user =  User.where(id: session[:user_id]).first

    if (@user == nil)
      puts 'hi'
      redirect_to login_path
      return @user
    else
      puts 'hey'
      return @user
    end
  end

  helper_method :signon

  helper_method :getUpComingBookings
  helper_method :getPastBookings
end
