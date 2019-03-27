class UserMailerPreview < ActionMailer::Preview
  # http://localhost:3000/rails/mailers/user_mailer/booking_confirm
  def booking_confirm
    user = User.second
    booking = user.bookings.first
    UserMailer.booking_confirm(user, booking)
  end
end
