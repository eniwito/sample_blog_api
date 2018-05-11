require 'rails_helper'

RSpec.describe Ip, type: :model do
  describe 'associations' do
    it { should have_many :posts }
  end
end