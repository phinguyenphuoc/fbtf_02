class ToursController < ApplicationController
  before_action :load_tour_details, only: :show
  before_action :current_user, only: :show

  def show
    @review  = current_user.reviews.build if logged_in?
    @reviews = @tour_details.reviews.order(created_at: :desc)
  end

  private

  def load_tour_details
    @tour_details = Tour.find_by id: params[:id]
    return if @tour_details
    flash[:danger] = t "no_data"
    redirect_to tour_path
  end
end
