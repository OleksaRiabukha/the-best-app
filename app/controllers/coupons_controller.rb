class CouponsController < ApplicationController
  before_action :authenticate_user!

  def new; end

  def create
    @session = StripeCheckout.create_stripe_checkout(coupon_params[:amount],
                                                     successful_coupon_checkout_url,
                                                     cancel_coupon_checkout_url,
                                                     current_user)
    render json: { status: 200, session: @session }.to_json
  end

  def successful_coupon_checkout
    flash[:notice] = 'Thank you! We have added coupon to our wallet'
    redirect_to restaurants_path
  end

  def cancel_coupon_checkout
    StripeCheckout.cancel_payment_intent(params[:stripe_session_id])
    redirect_to new_coupon_path
  end

  private

  def coupon_params
    params.require(:coupon).permit(:coupon_number, :amount)
  end
end
