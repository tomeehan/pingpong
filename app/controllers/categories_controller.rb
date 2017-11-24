class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new

    if @category.save!(category_params)
      redirect_to matches_path
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :win, :loss, :victory)
  end
end
