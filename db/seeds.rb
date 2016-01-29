# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#articles:

count = 100

count.times do |n|
  title = Faker::Lorem.sentence(1)
  content = Faker::Lorem.sentence(500)
  Article.create!(title: title,
                  content: content,
                  created_at: rand(24).month.ago)
end

articles = Article.all.take(count/2)

articles.each do |article|
  rand(10).times do |i|
    name = Faker::Name.name
    email = "example-#{i+1}@example.com"
    content = Faker::Lorem.sentence(5)
    time = rand(6000).minutes.ago
    article.comments.create!(commenter: name, email: email, content: content,
                             created_at: time)
  end
end
