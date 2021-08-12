class AdminPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end
end
