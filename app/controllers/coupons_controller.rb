class CouponsController < ApplicationController
  before_action :authenticate_user!

  def new; end

  def create
    render json: {status: 200, redirect_link: restaurants_path}.to_json
    flash[:notice] = "You have successfully bought a coupon!"
  end

  private

  def coupon_params
    params.require(:coupon).permit(:coupon_number, :amount)
  end
end
