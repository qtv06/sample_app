class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    return if @user
    flash.now[:danger] = I18n.t "users.flash.not_found"
    redirect_to root_path
  end

  def create
    @user = User.new user_params
    if @user.save
      flash.now[:success] = I18n.t "users.flash.success"
      redirect_to @user
    else
      flash.now[:danger] = I18n.t "users.flash.danger"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
