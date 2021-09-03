class RestaurantsController < ApplicationController

  def index
    @restaurants = collection.includes(:category, restaurant_image_attachment: :blob)
  end

  def show
    @restaurant = collection.find(params[:id])
    respond_to :html, :js
  end

  private

  def collection
    Restaurant.active
  end
end
