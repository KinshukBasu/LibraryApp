include Record
class AccessController < ApplicationController

  before_filter :signon

  private

  def signon
    @user =  User.where(id: session[:user_id]).first

    if (@user == nil)

      redirect_to login_path
      return @user
    else

      return @user
    end
  end

  helper_method :signon

  helper_method :getUpComingBookings
  helper_method :getPastBookings
end