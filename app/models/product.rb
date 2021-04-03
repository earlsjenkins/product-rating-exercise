class Product < ApplicationRecord
  has_many :reviews

  scope :best_to_worst, -> { left_joins(:reviews).group("products.id").order("AVG(reviews.rating) DESC NULLS LAST") }
  scope :most_recent, -> { order(created_at: :desc) }

  def rating
    reviews.average :rating
  end
end
