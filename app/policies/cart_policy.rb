class CartPolicy < ApplicationPolicy
  attr_reader :user, :cart

  def initialize(user, cart)
    @user = user
    @cart = cart
  end

  def show?
    same_user
  end

  def destroy?
    same_user
  end

  def same_user
    user.id == cart.user.id
  end
end
