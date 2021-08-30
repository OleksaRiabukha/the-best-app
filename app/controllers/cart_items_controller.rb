class CartItemsController < ApplicationController

  before_action :current_cart, only: %i[create destroy]
  before_action :find_cart_item, only: %i[show destroy]

  def new
    @cart_item = CartItem.new
  end

  def create
    menu_item = MenuItem.find(params[:menu_item_id])
    @cart_item = @cart.add_menu_item(menu_item)

    if @cart_item.save
      render '/shared/cart_modal'
    else
      render :new
    end
  end

  def destroy
    if @cart_item.check_quantity && @cart.is_empty?
      @cart.destroy
      redirect_to @cart_item.menu_item.restaurant
    else
      render '/shared/cart_modal'
    end
  end

  private

  def find_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:menu_item_id)
  end

  def current_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end
