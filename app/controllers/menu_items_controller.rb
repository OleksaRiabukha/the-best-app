class MenuItemsController < ApplicationController
  def show
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu_item = @restaurant.menu_items.includes(:menu_item_image_attachment).find(params[:id])
  end
end
