class OrdersController < ApplicationController
  include CurrentCart

  before_action :authenticate_user!
  before_action :current_cart, only: %i[new create]
  before_action :current_cart_items, only: %i[new create]
  before_action :ensure_cart_is_not_empty, only: :new
  before_action :find_order, only: %i[show edit update destroy]

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.add_cart_items_from_cart(@cart)

    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      flash[:notice] = 'Thank you! We have already started proccessing your order'
      redirect_to restaurants_path
    else
      render :new
    end
  end

  private

  def ensure_cart_is_not_empty
    redirect_to restaurants_path, flash[:alert] = 'Cart is empty!' if @cart.is_empty?
  end

  def find_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:city, :street, :building, :appartment_number, :pay_type)
  end
end
