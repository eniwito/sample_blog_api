require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to :ip }
    it { should have_many :post_ratings }
  end
end