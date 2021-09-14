class HomeController < ApplicationController
  def index
    @restaurants = Restaurant.active.includes(restaurant_image_attachment: :blob)
  end
end
