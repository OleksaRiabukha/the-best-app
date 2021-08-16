class Admin::CategoriesController < Admin::AdminController
  before_action :set_category, only: %i[show edit update destroy]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = 'Successfully created!'
      redirect_to admin_categories_path(@category)
    else
      render :new
    end
  end

  def index
    @categories = Category.all
  end

  def show; end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Successfully updated'
      redirect_to admin_categories_path(@category)
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = 'Successfully deleted!'
      redirect_to admin_categories_path
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
