class Admin::DashboardPolicy < AdminPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end
end