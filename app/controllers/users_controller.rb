class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  def index
    @users = User.paginate page: params[:page]
  end

  def show
    @microposts = @user.microposts.paginate page: params[:page]
    return if @user
    flash.now[:danger] = I18n.t "users.flash.not_found"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activated_email
      flash[:info] = I18n.t "users.flash.info"
      redirect_to root_url
    else
      flash[:danger] = I18n.t "users.flash.danger"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = I18n.t "users.flash.update_succ"
      redirect_to @user
    else
      flash.now[:danger] = I18n.t "users.flash.danger"
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = I18n.t "users.flash.delete_succ"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find_by id: params[:id]
    @users = @user.following.paginate(page: params[:page])
    render :show_follow
  end

  def followers
    @title = "Followers"
    @user  = User.find_by id: params[:id]
    @users = @user.followers.paginate(page: params[:page])
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
    redirect_to root_url if @user.blank?
  end
end
