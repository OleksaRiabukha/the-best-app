class OrdersController < ApplicationController
  include StripeCheckout

  before_action :authenticate_user!
  before_action :current_cart, only: %i[new create successful_checkout cancel_checkout]

  before_action :current_cart_items, only: %i[new create cancel_checkout]
  before_action :ensure_cart_is_not_empty, only: :new
  before_action :find_order, only: %i[show edit update destroy]

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(order_params)

    render '/orders/order_form' and return unless @order.valid?

    @order.save

    if @order.pay_type == 'Card'
      @session = StripeCheckout.create_stripe_checkout(@cart,
                                                       successful_checkout_url,
                                                       cancel_checkout_url,
                                                       current_user)
      render '/orders/create'
    else
      @order.add_cart_items_from_cart(@cart)
      destroy_cart
      flash[:notice] = 'Thank you! We have already started processing your order'
      redirect_to restaurants_path
    end
  end

  def successful_checkout
    @order = current_user.orders.first

    @order.add_cart_items_from_cart(@cart)
    destroy_cart
    flash[:notice] = 'Thank you! We have already started processing your order'
    redirect_to restaurants_path
  end

  def cancel_checkout
    @order = current_user.orders.first

    @order.destroy
    StripeCheckout.cancel_payment_intent(params[:stripe_session_id])
    redirect_to orders_new_path
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
