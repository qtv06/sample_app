class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && (user.authenticate params[:session][:password])
      if user.activated?
        log_in user
        remember_acc user
        flash[:success] = I18n.t "users.flash.success"
        redirect_to user
      else
        flash[:danger] = I18n.t "users.flash.messages_activated"
      end
    else
      flash[:danger] = I18n.t "users.flash.login_faild"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def remember_acc user
    params[:session][:remember_me] == Settings.remember_checked ? remember(user) : forget(user)
  end
end
