class BookingsController < ApplicationController
  before_action :find_tour, only: [:show, :create]
  # before_action :find_quantity, only: :show
  before_action :booking_params, only: :create

  def show
    @booking = Booking.new
  end

  def create
    @booking = current_user.bookings.new booking_params
    @booking.tour_id = @tour.id
    @count = @tour.max_quantity - @tour.recent_quantity
    @booking.bill = @booking.quantity * @tour.price
    save_booking
  end

  private

  def save_booking
    if @count < @booking.quantity
      flash[:danger] = t "booking_fail"
    elsif @booking.save
      @tour.recent_quantity += @booking.quantity
      @tour.update_attributes(recent_quantity: @tour.recent_quantity)
      flash[:success] = t "booking_success"
    else
      flash[:danger] = t "booking_fail1"
    end
    redirect_to root_path
  end

  def booking_params
    params.require(:booking).permit :name, :phonenumber,
      :address, :quantity, :note
  end

  def find_tour
    @tour = Tour.find_by id: params[:tour_id]
    return if @tour
    flash[:danger] = t "no_data"
    redirect_to root_path
  end

  # def find_quantity
  #   @quantity = params[:quantity]
  #   return if @quantity
  #   flash[:danger] = t "no_data"
  #   redirect_to root_path
  # end
end
