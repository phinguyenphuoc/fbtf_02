class Admin::ToursController < Admin::AdminBaseController
  before_action :check_permission

  def index
    # @tours = Tour.order_new_tours.paginate page: params[:page],
    #   per_page: Settings.travelling_per_page
    @tours = Tour.preload(:travelling).order_new_tours.paginate page: params[:page],
       per_page: Settings.travelling_per_page
  end

  def new
    @travellings = Travelling.all.map do |e|
      ["#{e.start_name} - #{e.end_name}", e.id]
    end
    @tour = Tour.new
  end

  def create
    @tour = Tour.new tour_params
    if @tour.save
      flash[:success] = t "add_tour_sucess"
      redirect_to admin_tours_path
    else
      render :new
    end
  end

  private

  def tour_params
    params.require(:tour).permit :category_id, :travelling_id, :price,
      :time_start, :time_end, :max_quantity
  end
end
