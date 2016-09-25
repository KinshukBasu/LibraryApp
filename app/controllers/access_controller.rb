include Record
class AccessController < ApplicationController

  before_filter :signon

  private

  def signon
    @user =  session[:user]

    if (@user == nil)

      redirect_to login_path
      return @user
    end

      return @user

  end

  helper_method :signon

  helper_method :getUpComingBookings
  helper_method :getPastBookings
  helper_method :getOngoingBookings
end