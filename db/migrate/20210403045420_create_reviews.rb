class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews, id: :uuid do |t|
      t.references :product, type: :uuid

      t.string :author_name, null: false
      t.integer :rating, null: false
      t.string :headline, null: false
      t.text :body

      t.timestamps
    end
  end
end
