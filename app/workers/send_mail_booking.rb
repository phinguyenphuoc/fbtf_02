class SendMailBooking
  include Sidekiq::Worker

  def perform current_user, booking
    UserMailer.booking_confirm(current_user, booking).deliver
  end
end
