class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.active
  end

  def show
    @restaurant = Restaurant.active.find(params[:id])
  end
end
