# User created
User.create!(name: "Admin",
            email: "admin@example.com",
            role: 1,
            password: "012398",
            password_confirmation: "012398")
30.times do |n|
  name = Faker::Name.name
  email = "user#{n}@example.com"
  role = 0
  password = "012398"
  password_confirmation = "012398"
  User.create!(name: name, email: email, role: role,
              password: password, password_confirmation: password_confirmation)
end

Category.create!(name: "Fiction")
Category.create!(name: "Technology")
Category.create!(name: "Managa")
Category.create!(name: "Finacial")
Category.create!(name: "Histoty")
Category.create!(name: "News")

100.times do |_n|
  title = Faker::Book.title
  description = Faker::Lorem.paragraph
  published_time = Faker::Date.between(from: "1900-01-01", to: "2010-12-31")
  page_num = rand(100..1000)
  author = Faker::Book.author
  category_id = rand(1..5)
  Book.create!(title: title, description: description,
    published_time: published_time, page_num: page_num,
    author: author, category_id: category_id)
end

100.times do |n|
  Review.create!(user_id: rand(1..30), book_id: n + 1,
                review_title: Faker::Lorem.sentence,
                review_content: Faker::Lorem.paragraph(sentence_count: 10,
                   supplemental: false, random_sentences_to_add: 20))
end
# 100.times do |_n|
#   UserBook.create!(user_id: 1, book_id: 1, status: 1, rating_point: 9.5)
# end
# Comment.create!(user_id: 2, review_id: 1, comment_content: "Ok Bro!")
# Reply.create!(user_id: 1, comment_id: 1, reply_content: "Like")
