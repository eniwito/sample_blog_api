require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many :posts }
    it { should have_and_belong_to_many :ips }
  end
end