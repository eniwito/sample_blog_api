class PostRatingIncreaser
  include ActiveModel::Validations
  include ActiveModel::Callbacks

  validate :post_present
  validates :post_id, :rating, presence: true
  validates :rating, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5
  }

  define_model_callbacks :save, only: [:after]
  after_save :recalculate_avg_rating

  attr_reader :post_id, :rating, :post

  def initialize(post_rating_params, post_id)
    @post_id = post_id
    @rating = post_rating_params[:rating]
  end

  def save
    run_callbacks :save do
      return if invalid?
      @post_rating = PostRating.create(post_id: @post_id, rating: @rating)
    end
  end

  private

    def post_present
      errors.add(:post_id, "record not found") unless Post.exists?(id: @post_id)
    end

    def recalculate_avg_rating
      @post = Post.find(@post_id)
      avg_rating = PostRating.where(post: @post).average(:rating)
      @post.update(avg_rating: avg_rating)
    end

end