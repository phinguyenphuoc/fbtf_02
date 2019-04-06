class ToursController < ApplicationController
  before_action :load_tour_details, :current_user, only: :show

  def show
    @reviews = @tour_details.reviews.to_a
    @avg_rating = @reviews.blank? ? 0 : @tour_details.reviews.average(:rating)
    @review  = current_user.reviews.build if user_signed_in?
    @reviews = @tour_details.reviews.order_reviews
    if request.xhr?
      render json: {
        addresses: @tour_details.travelling.location_end
      }
    end
  end

  private

  def load_tour_details
    @tour_details = Tour.find_by id: params[:id]
    return if @tour_details
    flash[:danger] = t "no_data"
    redirect_to tour_path
  end
end
