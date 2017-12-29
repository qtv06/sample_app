class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
    @micropost = current_user.microposts.build
    @feed_items = Micropost.posted_by(current_user).sort_desc.paginate(page: params[:page], per_page: 10)
  end

  def help; end

  def about; end

  def contact; end
end
