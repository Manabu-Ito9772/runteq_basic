10.times do
  User.create!(last_name: Faker::Name.last_name,
              first_name: Faker::Name.first_name,
                   email: Faker::Internet.email,
                password: '12345',
   password_confirmation: '12345')
 end

 20.times do |index|
    Board.create!(user: User.offset(rand(User.count)).first,
                 title: "タイトル#{index}",
                  body: "本文#{index}")
  end
