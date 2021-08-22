module CurrentCart

  private

  # def current_cart
  #   @cart = current_user.cart
  # rescue ActiveRecord::RecordNotFound
  #   @cart = Cart.create
  #   @cart.user = current_user
  #   session[:cart_id] = @cart.id
  # end

  def current_cart
    if current_user.cart
      @cart = current_user.cart
    else
      @cart = current_user.build_cart
      # session[:cart_id] = @cart.id
    end
  end
end
