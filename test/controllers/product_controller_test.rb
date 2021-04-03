require 'test_helper'

class ProductControllerTest < ActionDispatch::IntegrationTest

  test "should get index in the correct order" do
    get product_index_url
    assert_response :success
    parsed_response = response.parsed_body
    product_names = parsed_response.collect {|item| item["name"]}
    assert_equal product_names, ["Product One", "Product Three", "Product Two"]
  end

  test "should get show for valid product id" do
    product_one = Product.first
    get product_url(product_one)
    assert_response :success
  end

  test "should fail show for invalid product id" do
    get product_url("not-a-real-id")
    assert_response :not_found
  end

end
