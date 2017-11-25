class CategoriesController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save!
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
