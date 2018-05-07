class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user
      t.references :ip
      t.string :title
      t.text :body
      t.decimal :avg_rating, default: 0.0, precision: 7, scale: 5

      t.timestamps
    end
  end
end
