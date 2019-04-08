class StaticPagesController < ApplicationController
  def home
    @new_tour = Tour.where_time_start(Date.current)
                    .order_new_tours
                    .limit(Settings.static_pages.new_tours)
    @q = Tour.search(params[:q])
    @tours = @q.result.paginate(page: params[:page],
                   per_page: Settings.tours.per_page)
  end
end
