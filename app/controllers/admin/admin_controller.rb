class Admin::AdminController < ApplicationController
  before_action :require_admin

  private

  def require_admin
    policy_scope(%i[admin restaurants])
  end
end
