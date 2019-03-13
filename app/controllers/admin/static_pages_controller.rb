class Admin::StaticPagesController < Admin::AdminBaseController
  before_action :check_permission, only: :show

  def show; end
end
