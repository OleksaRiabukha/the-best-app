class Admin::DashboardController < Admin::AdminController
  def index
    @pagy, @restaurants = pagy(Restaurant.all, items: 9)
  end
end
