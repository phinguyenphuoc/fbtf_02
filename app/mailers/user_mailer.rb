class UserMailer < ApplicationMailer
  def booking_confirm user, booking
    @booking = booking
    @user = user
    mail(to: @user.email, subject: t(".confirm_booking"))
  end
end
