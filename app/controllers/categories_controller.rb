class CategoriesController < ApplicationController
  before_action :require_user?, only: [:new, :create]
  before_action :require_admin, except: [:index, :show]

  def new
    @category = Category.new
  end
  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "Category has been created!"
      redirect_to root_path
    else
      render :new
    end
  end
  def show
    @category = Category.find((params[:id]))
    @posts = @category.posts
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end
