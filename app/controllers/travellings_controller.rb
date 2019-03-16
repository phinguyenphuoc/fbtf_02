class TravellingsController < ApplicationController
  def index
    @travellings = Travelling.all.group(:location_end_id)

    @tours = if params[:location_end_id]
               Travelling.where(location_end_id: params[:location_end_id])
             else
               Travelling.all
             end
  end
end
