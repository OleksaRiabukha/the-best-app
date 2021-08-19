class MenuItemsController < ApplicationController
  def show
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu_item = @restaurant.menu_items.find(params[:id])
  end
end
