class Post < ApplicationRecord
  belongs_to :user
  belongs_to :ip
  
  has_many :post_ratings, dependent: :destroy

  scope :top, -> (count) { order(avg_rating: :desc).limit(count) }
end
