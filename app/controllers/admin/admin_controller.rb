class Admin::AdminController < ApplicationController
  before_action :authorize_access
  
  private 

  def authorize_access
    policy_scope([:admin, :restaurants])
  end
end
