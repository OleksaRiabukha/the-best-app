class RestaurantsController < ApplicationController
  def index
    @restaurants = collection
  end

  def show
    @restaurant = collection.find(params[:id])
  end

  private

  def collection
    Restaurant.active
  end
end
