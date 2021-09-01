module CurrentCart
  def current_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  def current_cart_items
    @cart_items = @cart.cart_items.includes(:menu_item) if @cart
  end
end
