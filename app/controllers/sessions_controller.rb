class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = I18n.t "users.flash.success"
      redirect_to user
    else
      flash[:danger] = I18n.t "users.flash.login_faild"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
