class Admin::DashboardController < Admin::AdminController
  def index
    @restaurants = Restaurant.all
  end
end
