class Admin::UsersController < Admin::AdminBaseController
  before_action :check_permission
  before_action :load_user, only: %i(destroy show)

  def show
    @bookings = @user.bookings.page(params[:page]).per(5)
    @sum = 0
  end

  def index
    @users = User.all_except(current_user).page(params[:page])
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        flash[:success] = t "del_user_success"
      else
        flash[:danger] = t "del_user_failed"
      end
      format.js
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "err_user"
    redirect_to admin_users_path
  end
end
