class PostCreator
  include ActiveModel::Validations

  validates :title, :body, :login, :ip, presence: true

  attr_reader :title, :body, :login, :ip, :post

  def initialize(post_params, user_params)
    @title = post_params[:title]
    @body = post_params[:body]
    
    @login = user_params[:login]
    @ip = user_params[:ip]
  end

  def save
    return if invalid?
    user = User.find_or_create_by(login: @login)
    ip = Ip.find_or_create_by(ip: @ip)
    ip.users << user unless ip.users.include?(user)
    @post = Post.create(title: @title, body: @body, user: user, ip: ip)
  end
end