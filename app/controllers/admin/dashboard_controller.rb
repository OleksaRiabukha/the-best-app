class Admin::DashboardController < ApplicationController
  def index
    policy_scope([:admin, :dashboard])
  end
end