class CategoriesController < ApplicationController
  def index
  	@category = Category.all
  end

  def show
  end

  def new
	@category = Catergory.new
  end

  def edit
  end
end
