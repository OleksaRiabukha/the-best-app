class UsersController < ApplicationController
  before_action :authenticate_user!

  def show; end

  def edit; end

  def update
    if current_user.update(user_params)
      bypass_sign_in(current_user)
      flash[:notice] = "Successfully updated!"
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    if current_user.destroy
      flash[:notice] = "Successfully deleted!"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :phone_number)
  end
end