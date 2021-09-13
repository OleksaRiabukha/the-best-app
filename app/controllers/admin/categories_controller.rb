class Admin::CategoriesController < Admin::AdminController
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @pagy, @categories = pagy(Category.all, items: 10)
  end

  def show; end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = 'Successfully created!'
      redirect_to admin_category_path(@category)
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Successfully updated'
      redirect_to admin_category_path(@category)
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = 'Successfully deleted!'
    redirect_to admin_categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
