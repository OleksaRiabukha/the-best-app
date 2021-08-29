class CartsController < ApplicationController
  before_action :find_cart, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def new
    @cart = Cart.new
  end

  def show; end

  def destroy
    @cart.destroy
    session[:cart_id] = nil
    flash[:notice] = 'Your cart is empty!'
    redirect_to restaurants_path
  end

  private

  def find_cart
    @cart = Cart.find(params[:id])

    if same_cart?(@cart)
      @cart
    else
      invalid_cart
    end
  end

  def invalid_cart
    flash[:alert] = 'Invalid Cart, please try again'
    redirect_to root_path
  end

  def same_cart?(cart)
    cart.id == session[:cart_id]
  end
end
