require 'test_helper'

class ReviewControllerTest < ActionDispatch::IntegrationTest

  test "should get index for valid product id" do
    product_one = Product.first
    get product_review_index_url(product_one)
    assert_response :success
  end

  test "should fail index for invalid product id" do
    get product_review_index_url("not-a-real-id")
    assert_response :not_found
  end

  test "should get index in the correct default order" do
    product_three = Product.find_by(name: "Product Three")
    get product_review_index_url(product_three)
    assert_response :success
    parsed_response = response.parsed_body
    dates = parsed_response.collect {|item| DateTime.parse item["created_at"]}
    assert_equal dates, dates.sort
  end

  test "should get index in the correct ratings order" do
    product_three = Product.find_by(name: "Product Three")
    get product_review_index_url(product_three, sort_by: "rating", order: "asc")
    assert_response :success
    parsed_response = response.parsed_body
    ratings = parsed_response.collect {|item| item["rating"].to_i}
    assert_equal ratings, ratings.sort
  end

  test "should create a new article when given valid parameters" do
    product_two = Product.find_by(name: "Product Two")
    assert_difference ->{ Review.count } => 1, -> { product_two.reload.reviews.count } => 1 do
      create_params = {
        author_name: "Test Author",
        rating: 1,
        headline: "I hated this. It sucked.",
        body: "What more can I say. Would NOT recommend."
      }
      post product_review_index_url(product_two, create_params)
      assert_response :success
    end
  end

  test "should NOT create a new article when given invalid parameters" do
    assert_no_difference ->{ Review.count } do
      create_params = {
        rating: "sucky",
        body: "What more can I say. Would NOT recommend."
      }
      product_two = Product.find_by(name: "Product Two")
      post product_review_index_url(product_two, create_params)
      assert_response :unprocessable_entity
      assert_equal response.parsed_body, {"message"=>"Validation failed: Author name can't be blank, Headline can't be blank, Rating is not a number"}
    end
  end

end
