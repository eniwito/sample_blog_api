class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  has_and_belongs_to_many :ips

  def self.ip_list
    Ip.all.map do |ip|
      { ip: ip.ip.to_s, logins: ip.users.uniq.pluck(:login) }
    end
  end
end
