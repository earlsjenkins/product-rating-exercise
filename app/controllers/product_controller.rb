class ProductController < ApplicationController
  def index
    @products = Product.best_to_worst.most_recent.all
    json_response(@products)
  end

  def show
    json_response(Product.find(params[:id]))
  end
end
