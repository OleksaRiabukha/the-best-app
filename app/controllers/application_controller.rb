class ApplicationController < ActionController::Base
  include Pundit
  include CurrentCart

  before_action :current_cart
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_paper_trail_whodunnit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name phone_number])
  end

  private

  def user_not_authorized
    flash[:alert] = "You're not authorized. Contact admin"
    redirect_to root_path
  end
end
