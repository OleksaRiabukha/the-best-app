class Admin::AdminController < ApplicationController
  before_action :require_admin

  private

  def require_admin
    policy_scope([:admin, :restaurants])
  end
end
