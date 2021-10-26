class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, Rails.application.credentials.dig(:stripe, :webhook)
      )
    rescue JSON::ParserError => e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      puts 'Signature invalid'
      p e
    end

    session = stripe_session(event)
    payment_succeeded = 'payment_intent.succeeded'
    payment_for = payment(session) if event.type == payment_succeeded

    case [event.type, payment_for]
    when [payment_succeeded, 'order']
      order(session)

      @order.paid
      @order.add_stripe_payment_id(session.id)
    when [payment_succeeded, 'coupon']
      params = coupon_params(session)

      coupon = CouponCreator.create(params['amount'], params['for_present'])
    end

    render json: { message: 'success' }
  end

  private

  def stripe_session(event)
    event.data.object
  end

  def order(session)
    @user = User.find_by(stripe_customer_id: session.customer)
    @order = @user.orders.first
  end

  def payment(session)
    session.metadata.payment_for
  end

  def coupon_params(session)
    JSON.parse(session.metadata.model)
  end
end
