# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#articles:

count = 10

count.times do |n|
  Article.create!(title: "i am the #{n+1}th article",
                  content: "this is text for #{n+1}th article",
                  created_at: rand(2).year.ago)
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
