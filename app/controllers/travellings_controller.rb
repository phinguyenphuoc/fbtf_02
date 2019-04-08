class TravellingsController < ApplicationController
  def index
    @travellings = Travelling.all.group_travellings

    @travelling = if params[:location_end_id]
                    Travelling.where_travellings(params[:location_end_id])
                  else
                    Travelling.all
                  end
    @q = Tour.search(params[:q])
    if params[:q]
      @tours = @q.result.paginate(page: params[:page],
        per_page: Settings.tours.per_page)
    else
      @tours = Tour.search_tour_by_travelling_id(@travelling.pluck(:id))
        .where_time_start(Date.current)
        .paginate(page: params[:page], per_page: Settings.tours.per_page)
    end
  end
end
