class Review < ApplicationRecord
  MIN_RATING = 1.freeze
  MAX_RATING = 5.freeze

  belongs_to :product

  validates_presence_of :author_name, :rating, :headline
  validates_numericality_of :rating, only_integer: true, greater_than_or_equal_to: MIN_RATING, less_than_or_equal_to: MAX_RATING
end
