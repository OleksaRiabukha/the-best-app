class HomeController < ApplicationController
  def index
    @restaurants = Restaurant.active.includes(:category)
  end
end
