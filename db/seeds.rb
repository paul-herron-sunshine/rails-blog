User.create!(name:  "Fraser Johnstone",
             email: "fraserjohnstone12345@hotmail.com",
             password:              "Mancini2180",
             password_confirmation: "Mancini2180",
             admin: true,
             activated: true,
             activated_at: Time.zone.now,
             last_active_at:Faker::Time.between(365.days.ago, Time.now),
             views: Random.rand(0..1500))

User.create!(name:  "Paul Herron",
             email: "paul.herron@onthebeach.co.uk",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now,
             last_active_at:Faker::Time.between(365.days.ago, Time.now),
             views: Random.rand(0..1500))

User.create!(name:  "Kirstie Davidson",
             email: "kirstie.davidson@onthebeach.co.uk",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now,
             last_active_at:Faker::Time.between(365.days.ago, Time.now),
             views: Random.rand(0..1500))

97.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@hotmail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               last_active_at:Faker::Time.between(365.days.ago, Time.now),
               views: Random.rand(0..1500))

end
