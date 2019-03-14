class ToursController < ApplicationController
  before_action :hot_tour, only: :index

  def index
    hot_tour
    if params[:name_end]
      if_tours
    else
      else_tours
    end
  end

  private

  def hot_tour
    @travel_end = Travelling.location_end.join_tour
                            .join_location_start
                            .join_location_end
                            .order_count.group_id_end
  end

  def if_tours
    @tours = Travelling.list_tours
                       .join_tour
                       .join_location_start
                       .join_location_end
                       .where("l2.name = ?", params[:name_end])
                       .paginate(page: params[:page],
                        per_page: Settings.tours.per_page)
  end

  def else_tours
    @tours = Travelling.list_tours
                       .join_tour
                       .join_location_start
                       .join_location_end
                       .paginate(page: params[:page],
                        per_page: Settings.tours.per_page)
  end
end
