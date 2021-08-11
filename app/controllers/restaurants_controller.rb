class RestaurantsController < ApplicationController
  before_action :authenticate_user!

  def index
    @restaurants = Restaurant.active
  end

  def show
    @restaurant = authorize Restaurant.find(params[:id])
  end
end