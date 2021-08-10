class Admin::DashboardController < ApplicationController
  def index
    policy_scope([:admin, :dashboard])
    @restaurants = Restaurant.all
  end
end
