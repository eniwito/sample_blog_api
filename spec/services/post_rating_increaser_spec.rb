require 'rails_helper'

RSpec.describe PostRatingIncreaser do
  fixtures :posts, :users, :ips

  describe '#save' do
    context 'with valid params' do
      let(:valid_post) { posts(:valid) }
      let(:valid_post_rating_params) { { rating: '5' } }

      context 'should save post rating' do
        subject { lambda { PostRatingIncreaser.new(valid_post_rating_params, valid_post.id).save } }

        it { should change(PostRating, :count).by 1 }
      end
    end

    context 'with invalid params' do
      let(:valid_post) { posts(:valid) }
      let(:invalid_post_rating_params) { { rating: '6' } }

      context 'should not save post rating' do
        subject { lambda { PostRatingIncreaser.new(invalid_post_rating_params, valid_post.id).save } }

        it { should_not change(PostRating, :count) }
      end
    end
  end
end