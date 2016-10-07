class SignUpController < ApplicationController
  def new
    @reader = User.new
  end

  # POST
  def create

    @adminUser = User.find_by(:email=> 'kinshuk@gmail.com')


    if(@adminUser != nil)
    @adminUser.update(:role => 'Super')
    end

    @reader = User.new(reader_params)

    if(@reader.save)

      render :json =>{:message => "success"}
      return
    else

     message = ""
      @reader.errors.messages.each do|k,n|
        message = message.concat(n[0].to_s).concat("<br>")
      end

     message = message.chomp('<br>')

      render :json =>{:message => message}
      return
    end
  end

private

  def reader_params
    params.require(:user).permit(:name, :password, :password_confirmation, :role, :address, :phoneNumber, :email)
  end
end
