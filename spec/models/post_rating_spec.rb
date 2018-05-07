require 'rails_helper'

RSpec.describe PostRating, type: :model do
  describe 'associations' do
    it { should belong_to :post }
  end
end