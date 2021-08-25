class CartItemsController < ApplicationController
  include CurrentCart
  before_action :current_cart, only: %i[create destroy]
  before_action :find_cart_item, only: %i[show edit update destroy]

  def new
    @cart_item = CartItem.new
  end

  def create
    menu_item = MenuItem.find(params[:menu_item_id])
    @cart_item = @cart.add_menu_item(menu_item)

    if @cart_item.save
      respond_to do |format|
        format.js { render template: '/shared/cart_modal.js.slim' }
      end
    else
      render :new
    end
  end

  def destroy
    if @cart_item.quantity > 1
      @cart_item.minus_one
      respond_to do |format|
        format.js { render template: '/shared/cart_modal.js.slim' }
      end
    else
      @cart_item.destroy
      respond_to do |format|
        if @cart.is_empty?
          @cart.destroy
          format.html { redirect_to(@cart_item.menu_item.restaurant) }
        else
          format.js { render template: '/shared/cart_modal.js.slim' }
        end
      end
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
