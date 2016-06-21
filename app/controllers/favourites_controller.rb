class FavouritesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_create, only: :create
  before_action :authorize_destroy, only: :destroy

  def create
    favourite          = Favourite.new
    favourite.user     = current_user
    favourite.post = post
    if favourite.save
      redirect_to post, notice: "Favourited!"
    else
      redirect_to post, alert: "You're already favourited!"
    end
  end

  def index
    @favourites = current_user.favourites
  end
  

  def destroy
    favourite.destroy
    redirect_to post_path(favourite.post_id), notice: "Un-Favourite!"
  end

  private

  def authorize_create
    redirect_to post, notice: "Can't favourite!" unless can? :favourite, post
  end

  def authorize_destroy
    redirect_to post, notice: "Can't remove favourite!" unless can? :destroy, favourite
  end

  def post
    @post ||= Post.find params[:post_id]
  end

  def favourite
    @favourite ||= Favourite.find params[:id]
  end

end
