class Admin::StaticPagesController < Admin::AdminBaseController
  before_action :check_permission, only: :show
  def show; end

  private

  def check_admin
    if current_user.admin?
      render :show
    else
      flash[:danger] = t "permission_denide"
      redirect_to root_path
    end
  end

  def check_permission
    return unless logged_in?
    check_admin
  end
end
