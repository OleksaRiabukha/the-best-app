module StripeWebhookHeader
 
  def self.generate_request_header(event)
    signature = Stripe::Webhook::Signature.compute_signature(Time.now, event.to_s, Rails.application.credentials.dig(:stripe, :webhook))
    Stripe::Webhook::Signature.generate_header(Time.now, signature.to_s, scheme: 'v1')
  end
end
