#add 3 admin users
created_at = Faker::Time.between(750.days.ago, Time.now)
activated_at = Faker::Time.between(created_at, Time.now)
last_active_at = Faker::Time.between(activated_at, Time.now)
User.create!(name:  "Fraser Johnstone",
             email: "fraserjohnstone12345@hotmail.com",
             password:              "Mancini2180",
             password_confirmation: "Mancini2180",
             admin: true,
             created_at: created_at,
             activated: true,
             activated_at: activated_at,
             last_active_at: last_active_at,
             views: Random.rand(0..1500))

created_at = Faker::Time.between(750.days.ago, Time.now)
activated_at = Faker::Time.between(created_at, Time.now)
last_active_at = Faker::Time.between(activated_at, Time.now)
User.create!(name:  "Paul Herron",
             email: "paul.herron@onthebeach.co.uk",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             created_at: created_at,
             activated: true,
             activated_at: activated_at,
             last_active_at: last_active_at,
             views: Random.rand(0..1500))

created_at = Faker::Time.between(750.days.ago, Time.now)
activated_at = Faker::Time.between(created_at, Time.now)
last_active_at = Faker::Time.between(activated_at, Time.now)
User.create!(name:  "Kirstie Davidson",
             email: "kirstie.davidson@onthebeach.co.uk",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             created_at: created_at,
             activated: true,
             activated_at: activated_at,
             last_active_at: last_active_at,
             views: Random.rand(0..1500))

# add fake users
97.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@hotmail.com"
  password = "password"
  created_at = Faker::Time.between(750.days.ago, Time.now)
  activated_at = Faker::Time.between(created_at, Time.now)
  last_active_at = Faker::Time.between(activated_at, Time.now)
  User.create!(name:  name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               created_at: created_at,
               activated_at: activated_at,
               last_active_at: last_active_at,
               views: Random.rand(0..1500))

end

# add posts and comments
User.all.each do |user|
  Random.rand(1..15).times do |post_num|
    num_comments = Random.rand(0..7)

    title = Faker::FamilyGuy.quote
    post_txt = []
    Random.rand(1..4).times do
      post_txt << Faker::Lorem.paragraph(Random.rand(4..10))
    end

    post_txt = post_txt.join("\n\n")
    num_comments = Random.rand(0..7)
    post_created_at = Faker::Time.between(user.created_at, Time.now)
    post = Post.create!(title: title,
                 body: post_txt,
                 user_id: user.id,
                 votes: Random.rand(0..200),
                 created_at: post_created_at)

    num_comments.times do |t|
      txt = Faker::Lorem.sentences(Random.rand(1..3)).join
      comment_created_at = Faker::Time.between(post.created_at, Time.now)
      Comment.create!(body: txt,
                   user_id: user.id,
                   post_id: post.id,
                   created_at: comment_created_at)
    end
  end
end

# add conversations between users
User.all.each do |user|
  # create a number of conversations
  Random.rand(3..10).times do
    other_user = User.find(Random.rand(1..User.all.count-1))
    #create a number of interchanges between users
    Random.rand(1..15).times do
      Message.create!(body: Faker::Lorem.sentences(Random.rand(3..15)).join,
                      sender_id: user.id,
                      receiver_id: other_user.id)
      Message.create!(body: Faker::Lorem.sentences(Random.rand(3..15)).join,
                      sender_id: other_user.id,
                      receiver_id: user.id)
    end
  end
end
