namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end

# method to make users
def make_users
    admin = User.create!(name: "Example User",
                  email: "example@railstutorial.org",
                  password: "foobar",
                  password_confirmation: "foobar",
                  admin: true)
                  
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(name: name,
                    email: email,
                    password: password,
                    password_confirmation: password)
    end                 
end             
                
 def make_microposts               
   users = User.all(limit: 6)
   50.times do
       content = Faker::Lorem.sentence(5)
       users.each { |user| user.microposts.create!(content: content) }                  
     end
 end 
 
 def make_relationships
   users = User.all
   user = users.first
   followers = users[2..50]
   followed_users = users[3..40]
   #? w.o 'user.' how does ruby know that followed_users belongs to user?
   user.followed_users.each { |followed| user.follow!(followed) }
   followers.each      { |follower| follower.follow!(user) }
 end
   
