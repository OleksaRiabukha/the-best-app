class CartsController < ApplicationController
  include CurrentCart

  before_action :find_cart, only: %i[show destroy]
  before_action :current_cart_items, only: :show

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
    @cart.same?(session[:cart_id]) ? @cart : invalid_cart
  end

  def invalid_cart
    flash[:alert] = 'Invalid Cart, please try again'
    redirect_to root_path
  end
end
