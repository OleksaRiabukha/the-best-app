class RestaurantPolicy < ApplicationPolicy
  attr_reader :user, :restaurant

  def initialize(user, restaurant)
    @user = user
    @restaurant = restaurant
  end

  def show?
    restaurant.active? && !user.admin?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.active
      end
    end
  end
end
