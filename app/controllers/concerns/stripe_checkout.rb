module StripeCheckout
  def self.create_stripe_checkout(amount, payment_for, success_url, cancel_url, current_user, model)
    amount = (amount.to_d.round(2) * 100).to_i

    Stripe::Checkout::Session.create({ customer: current_user.stripe_customer_id,
                                       payment_method_types: [:card],
                                       line_items: [{
                                         name: 'Total price for the order:',
                                         amount: amount,
                                         currency: 'usd',
                                         quantity: 1
                                       }],
                                       payment_intent_data: {
                                         metadata: { payment_for: payment_for, model: model.to_json }
                                       },
                                       mode: 'payment',
                                       success_url: success_url,
                                       cancel_url: cancel_url + '?stripe_session_id={CHECKOUT_SESSION_ID}' })
  end

  def self.cancel_payment_intent(session_id)
    stripe_session = Stripe::Checkout::Session.retrieve(session_id)
    payment_intent_id = stripe_session.payment_intent
    Stripe::PaymentIntent.cancel(payment_intent_id)
  end
end
