class RestaurantPolicy < ApplicationPolicy
    attr_reader :user, :restaurant

    def initialize(user, restaurant)
      @user = user
      @restaurant = restaurant
    end
    
    def show?
      restaurant.active?
    end
end