class SessionsController < ApplicationController
  def new
    return redirect_to root_path if logged_in?
  end

  def create
    if request.env["omniauth.auth"]
      @user = User.create_with_omniauth(request.env["omniauth.auth"])
      log_in @user
      redirect_to user_path(@user)
    else
      load_user
      return login @user if @user&.authenticate params[:session][:password]
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
    flash[:danger] = t "err_login"
  end

  def login _user
    if @user.admin?
      log_in @user
      redirect_to admin_root_path
    else
      if params[:session][:remember_me] == Settings.sessions.remember_me
        remember(@user)
      else
        forget(@user)
      end
      log_in @user
      redirect_to root_path
    end
    flash.now[:danger] = t "err_login"
    render :new
  end
end
