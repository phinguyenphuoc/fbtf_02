class SessionsController < ApplicationController
  before_action :load_user, only: :create

  def new; end

  def create
    if @user&.authenticate params[:session][:password]
      login @user
    else
      flash.now[:danger] = t "errlogin"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def load_user
    @user = User.find_by email: params[:session][:email].downcase
    return if @user
    flash[:danger] = t "errlogin"
  end

  def login _user
    if @user.admin?
      log_in @user
      redirect_to root_path
    else
      if params[:session][:remember_me] == Settings.sessions.remember_me
        remember(@user)
      else
        forget(@user)
      end
      log_in @user
      redirect_to root_path
    end
  end
end
