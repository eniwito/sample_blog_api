class PostsController < ApplicationController
  def create
    result = PostCreator.new(post_params, user_params)
    
    if result.save
      render json: result.post, serializer: PostSerializer, status: :ok
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  def vote
    result = PostRatingIncreaser.new(post_rating_params, params[:id])
    
    if result.save
      render json: result.post, serializer: PostRatingSerializer, status: :ok
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  def top
    posts = Post.top(params[:count])

    render json: { posts: posts }, each_serializer: PostSerializer, status: :ok
  end

  def ip_list
    list = User.ip_list

    render json: list, status: :ok
  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end

    def user_params
      params.require(:user).permit(:login, :ip)
    end

    def post_rating_params
      params.require(:post).permit(:rating)
    end

end