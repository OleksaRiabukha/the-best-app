class RestaurantsController < ApplicationController

  def index
    @restaurants = collection.includes(:category, restaurant_image_attachment: :blob)
  end

  def show
    @restaurant = collection.find(params[:id])
    @menu_items = @restaurant.menu_items.available.includes(menu_item_image_attachment: :blob)
    respond_to :html, :js
  end

  private

  def collection
    Restaurant.active
  end
end
