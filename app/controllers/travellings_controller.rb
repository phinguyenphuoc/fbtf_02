class TravellingsController < ApplicationController
  def index
    @travellings = Travelling.all.group_travellings

    @tours = if params[:location_end_id]
               Travelling.where_travellings(params[:location_end_id])
             else
               Travelling.all
             end
  end
end
