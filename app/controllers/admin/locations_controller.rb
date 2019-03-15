class Admin::LocationsController < Admin::AdminBaseController
  def create
    @location = Location.new location_params
    if @location.save
      flash[:sucess] = t "add_location_sucess"
    else
      flash[:danger] = t "err_location"
    end
    redirect_to admin_locations_path
  end

  def index
    @location = Location.new
    @locations = Location.ordered_by_name.paginate page: params[:page],
      per_page: Settings.location_per_page
  end

  private

  def location_params
    params.require(:location).permit :name
  end
end
