module StripeCheckout
  def self.create_stripe_checkout(cart, order, success_url, cancel_url)
    amount = (cart.total_cart_price * 100).to_i

    Stripe::Checkout::Session.create({
      payment_method_types: [:card],
      line_items: [{
        name: 'Total price for the order:',
        amount: amount,
        currency: 'usd',
        quantity: 1
      }],
      metadata: {
        order: order,
        cart_id: cart.id
      },
      mode: 'payment',
      success_url: success_url,
      cancel_url: cancel_url

    })
  end
end
