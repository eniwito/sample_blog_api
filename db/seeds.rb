logins = []
100.times do
  logins << Faker::Internet.user_name
end

ips = []
50.times do 
  ips << Faker::Internet.ip_v4_address
end

200_000.times do
  post_params = { title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph }
  user_params = { login: logins.sample, ip: ips.sample }

  PostCreator.new(post_params, user_params).save
end

10_000.times do
  post_rating_params = { rating: rand(1..5) }
  post_id = rand(1..200_000)

  PostRatingIncreaser.new(post_rating_params, post_id).save
end
