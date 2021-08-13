class Admin::RestaurantsController < Admin::AdminController
  before_action :find_restaurant, only: %i[show update edit destroy]

  def show; end

  def new 
    @restaurant = Restaurant.new
  end

  def edit; end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    
    if @restaurant.save
      flash[:notice] = "Successfully added new restaurant!"
      redirect_to admin_restaurant_path(@restaurant)
    else
      render :new
    end
  end

  def update
    if @restaurant.update(restaurant_params)
      flash[:notice] = "Successfully updated restaurant details!"
      redirect_to admin_restaurant_path(@restaurant)
    else
      render :edit
    end
  end

  def destroy
    if @restaurant.destroy
      flash[:notice] = "Successfully deleted"
      redirect_to admin_dashboard_path
    end
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :phone_number, :description, :website_url, :active)
  end
end
