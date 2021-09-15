class OrdersController < ApplicationController
  include StripeCheckout

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
    render :new and return unless @order.valid?

    if @order.pay_type == 'Card'
      @order.save
      @session = StripeCheckout.create_stripe_checkout(@cart,
                                                       @order,
                                                       restaurants_url,
                                                       orders_new_url)
      flash[:notice] = 'Thank you! We have already started processing you order'
      render 'create'
    else
      @order.add_cart_items_from_cart(@cart)
      @order.save
      destroy_cart
      flash[:notice] = 'Thank you! We have already started processing your order'
      redirect_to restaurants_path
    end
  end

  private

  def ensure_cart_is_not_empty
    redirect_to restaurants_path, flash[:alert] = 'Cart is empty!' if @cart.is_empty?
  end

  def find_order
    @order = Order.find(params[:id])
  end

  def destroy_cart
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
  end

  def order_params
    params.require(:order).permit(:city, :street, :building, :appartment_number, :pay_type)
  end
end
