class RestaurantsController < ApplicationController

  def index
    @pagy, @restaurants = pagy(collection.includes(:category, restaurant_image_attachment: :blob), items: 6)
  end

  def show
    @restaurant = collection.find(params[:id])
    @pagy, @menu_items = pagy(@restaurant.menu_items.available.includes(menu_item_image_attachment: :blob), items: 6)
    respond_to :html, :js
  end

  private

  def collection
    Restaurant.active
  end
end
