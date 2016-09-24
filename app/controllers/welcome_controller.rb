class WelcomeController < AccessController
  def display
    @user = User.where(id: session[:user_id]).first
  end
end
