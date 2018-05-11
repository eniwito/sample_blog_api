class Ip < ApplicationRecord
  has_many :posts, dependent: :destroy

  scope :more_than_one_login, -> { group(:ip).select(:ip, 'array_agg(login) AS logins').having('count(*) > 1') }
end
