class CartItemsController < ApplicationController

  before_action :create_current_cart, only: %i[create destroy]
  before_action :current_cart_items, only: %i[create destroy]
  before_action :find_cart_item, only: %i[show destroy]

  def show; end

  def new
    @cart_item = CartItem.new
  end

  def create
    menu_item = MenuItem.find(params[:menu_item_id])
    @cart_item = @cart.add_menu_item(menu_item)

    if @cart_item.save
      render '/carts/show'
    else
      render :new
    end
  end

  def destroy
    if @cart_item.check_quantity && @cart.is_empty?
      @cart.destroy
      session[:cart_id] = nil
      redirect_to @cart_item.menu_item.restaurant
    else
      render '/carts/show'
    end
  end

  private

  def find_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:menu_item_id)
  end
end
