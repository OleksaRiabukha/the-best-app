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

    case event.type
    when 'checkout.session.completed'
      session = event.data.object
      @cart = session.metadata.cart_id
      Cart.destroy(@cart.id)
    end

    render json: { message: 'success' }
  end
end
