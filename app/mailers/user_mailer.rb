class UserMailer < ApplicationMailer

  def booking_intimation (user)
    @user = user
    mail(to: @user.email, subject: 'Wolfpack Library Booking Info')
  end
end
