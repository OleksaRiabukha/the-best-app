class RestaurantsController < ApplicationController
  before_action :authenticate_user!

  def index
    @restaurants = policy_scope(Restaurant)
  end

  def show
    @restaurant = authorize Restaurant.find(params[:id])
  end
end
