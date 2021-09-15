class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :current_cart, only: %i[new create]


  def new; end
  
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
      p 'Success'
    end

    render json: { message: 'success' }
  end
end
