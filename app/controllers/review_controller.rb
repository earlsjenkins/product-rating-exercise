class ReviewController < ApplicationController
  DEFAULT_SORT_COLUMN = "created_at".freeze
  ALLOWED_SORT_COLUMNS = %w[rating].freeze

  DEFAULT_SORT_ORDER = "desc".freeze
  ALLOWED_SORT_ORDERS = %w[asc desc].freeze

  def index
    json_response product.reviews.order(index_order)
  end

  def create
    json_response product.reviews.create!(create_params)
  end

  private

  def product
    @product ||= Product.find params[:product_id]
  end

  def index_order
    {sort_column => sort_order}
  end

  def sort_column
    colname = params[:sort_by].to_s.downcase
    colname = DEFAULT_SORT_COLUMN unless ALLOWED_SORT_COLUMNS.include?(colname)
    colname.to_sym
  end

  def sort_order
    order = params[:order].to_s.downcase
    order = DEFAULT_SORT_ORDER unless ALLOWED_SORT_ORDERS.include?(order)
    order.to_sym
  end

  def create_params
    params.permit :author_name, :rating, :headline, :body
  end
end
