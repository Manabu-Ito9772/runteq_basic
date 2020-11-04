10.times do
  User.create!(last_name: Faker::Name.last_name,
              first_name: Faker::Name.first_name,
                   email: Faker::Internet.email,
                password: '12345',
   password_confirmation: '12345')
 end

users = User.all
2.times do
  users.each { |user| user.boards.create!(title: Faker::Lorem.sentence,
                                           body: Faker::Lorem.sentence) }
end
