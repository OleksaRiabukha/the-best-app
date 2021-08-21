class CartsController < ApplicationController
  before_action :find_cart, only: %i[show edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def new
    @cart = Cart.new
  end

  def show; end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    flash[:notice] = 'Your cart is empty!'
    redirect_to restaurants_path
  end

  private

  def find_cart
    @cart = Cart.find(params[:id])
  end

  def invalid_cart
    flash[:alert] = 'Invalid Cart, please try again'
    redirect_to root_path
  end
end
