include Record

class WelcomeController < ApplicationController
  def display
    @user = User.where(id: session[:user_id]).first
  end

end


