class CreatePostRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :post_ratings do |t|
      t.references :post
      t.integer :rating

      t.timestamps
    end
  end
end
