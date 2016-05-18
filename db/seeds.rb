# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do
  Category.create(name: Faker::Hacker.adjective)
end

categories = Category.all

50.times do
  q = Post.create     title:      Faker::Company.bs,
                      body:       Faker::Lorem.paragraph,
                      category:   categories.shuffle.first,
                      user:       User.create(password: "password", password_confirmation: "password", first_name: Faker::StarWars.droid, last_name: Faker::StarWars.planet, email: Faker::Internet.email)

    10.times do
      random = rand(20)
      if random < 10
        q.comments.create(body: Faker::StarWars.quote)
      else
        q.comments.create(body: Faker::ChuckNorris.fact)
      end
    end
 end
