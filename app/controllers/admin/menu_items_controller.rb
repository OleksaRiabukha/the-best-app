class Admin::MenuItemsController < Admin::AdminController
  before_action :find_restaurant
  before_action :find_menu_item, only: %i[show edit update destroy]

  def show; end

  def new
    @menu_item = @restaurant.menu_items.build
  end

  def edit; end

  def create
    @menu_item = @restaurant.menu_items.build(menu_item_params)

    if @menu_item.save
      flash[:notice] = 'Successfully created!'
      redirect_to admin_restaurant_path(@restaurant)
    else
      render :new
    end
  end

  def update
    if @menu_item.update(menu_item_params)
      flash[:notice] = 'Successfully updated!'
      redirect_to admin_restaurant_path(@restaurant)
    else
      render :edit
    end
  end

  def destroy
    if @menu_item.destroy
      flash[:notice] = 'Successfully deleted!'
      redirect_to admin_restaurant_path(@restaurant)
    else
      flash[:alert] = @menu_item.errors.full_messages.join(' ')
      redirect_to admin_restaurant_menu_item_path(@restaurant, @menu_item)
    end
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def find_menu_item
    @menu_item = @restaurant.menu_items.find(params[:id])
  end

  def menu_item_params
    params.require(:menu_item).permit(:name,
                                      :description,
                                      :ingredients,
                                      :price,
                                      :discount,
                                      :available,
                                      :restaurant_id,
                                      :menu_item_image)
  end
end
