class IpListSerializer < ActiveModel::Serializer
  attributes :ip, :logins

  def ip
    object.ip.to_s
  end
end