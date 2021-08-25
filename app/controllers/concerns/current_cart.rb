module CurrentCart
  private

  def current_cart
    if current_user.cart
      @cart = current_user.cart
    else
      @cart = current_user.build_cart
    end
  end
end
