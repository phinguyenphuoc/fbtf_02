class Admin::LocationsController < Admin::AdminBaseController
  before_action :check_permission
  before_action :load_location, except: %i(index create)

  def edit; end

  def update
    if @location.update_attributes location_params
      flash[:success] = t "update_location_success"
      redirect_to admin_locations_path
    else
      flash[:danger] = t "update_location_failed"
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      if @location.destroy
        flash[:success] = t "del_location_success"
      else
        flash[:danger] = t "del_location_failed"
      end
      format.js
    end
  end

  def create
    @location = Location.new location_params
    respond_to do |format|
      if @location.save
        flash[:success] = t "add_location_success"
      else
        flash[:danger] = t "err_location"
      end
      format.js
    end
  end

  def index
    @location = Location.new
    @locations = Location.ordered_by_name.page(params[:page])
  end

  private

  def location_params
    params.require(:location).permit :name
  end

  def load_location
    @location = Location.find_by id: params[:id]
    return if @location
    flash[:danger] = t "err_location"
    redirect_to admin_locations_path
  end
end
