class CartsController < ApplicationController
  before_action :current_cart, only: %i[show]
  before_action :current_cart_items, only: :show

  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def new
    @cart = Cart.new
  end

  def show
    render '/shared/cart_modal'
  end

  def destroy
    @cart.destroy
    session[:cart_id] = nil
    flash[:notice] = 'Your cart is empty!'
    redirect_to restaurants_path
  end

  private

  def invalid_cart
    flash[:alert] = 'Invalid Cart, please try again'
    redirect_to root_path
  end
end
