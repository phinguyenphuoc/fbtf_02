class Admin::ToursController < Admin::AdminBaseController
  before_action :check_permission
  before_action :load_tour, only: %i(edit update destroy)
  before_action :load_travellings, only: %i(new edit)

  def index
    @tours =
      Tour.preload(:travelling).order_new_tours.paginate page: params[:page],
        per_page: Settings.travelling_per_page
  end

  def new
    @tour = Tour.new
    @categories = Category.all
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

  def edit; end

  def update
    if @tour.update_attributes tour_params
      flash[:success] = t "update_tour_success"
      redirect_to admin_tours_path
    else
      flash[:danger] = t "update_tour_failed"
    end
  end

  def destroy
    if @tour.bookings.blank? == false
      flash[:danger] = t "del_tour_failed"
      redirect_to request.referrer
    elsif @tour.destroy
      flash[:success] = t "del_tour_success"
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "del_tour_failed"
      redirect_to request.referrer
    end
  end

  private

  def load_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour
    flash[:danger] = t "err_tour"
    redirect_to admin_tours_path
  end

  def tour_params
    params.require(:tour).permit :category_id, :travelling_id, :price,
      :time_start, :time_end, :max_quantity
  end

  def load_travellings
    @travellings = Travelling.all.map do |e|
      ["#{e.start_name} - #{e.end_name}", e.id]
    end
  end
end
