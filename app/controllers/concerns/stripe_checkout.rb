module StripeCheckout
  def self.create_stripe_checkout(total_price, cart_items, success_url, cancel_url)
    amount = (total_price * 100).to_i

    Stripe::Checkout::Session.create({
      payment_method_types: [:card],
      line_items: [{
        name: 'Total price for the order:',
        amount: amount,
        currency: 'usd',
        quantity: 1
      }],
      mode: 'payment',
      success_url: success_url,
      cancel_url: cancel_url

    })
  end
end
