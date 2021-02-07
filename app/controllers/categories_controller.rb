class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @products = @category.products.order(created_at: :desc)
    @active_sale = Sale.active.first
  end

end
