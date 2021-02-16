# User created
User.create!(name: "Admin",
            email: "admin@example.com",
            role: 1,
            password: "012398",
            password_confirmation: "012398")
30.times do |n|
  name = "User#{n}"
  email = "user#{n}@example.com"
  role = 0
  password = "012398"
  password_confirmation = "012398"
  User.create!(name: name, email: email, role: role,
              password: password, password_confirmation: password_confirmation)
end

Category.create!(name: "Fiction")
Category.create!(name: "Technology")

30.times do |n|
  title = "Book #{n}"
  description = "Description #{n}"
  published_time = Date.new(2008, 1, 23)
  page_num = 10
  author = "Author#{n}"
  category_id = 1
  Book.create!(title: title, description: description,
    published_time: published_time, page_num: page_num,
    author: author, category_id: category_id)
end

# UserBook.create!(user_id: 1, book_id: 1, status: 1, rating_point: 9.5)
# Review.create!(user_id: 1, book_id: 2, review_content: "Great Book")
# Comment.create!(user_id: 2, review_id: 1, comment_content: "Ok Bro!")
# Reply.create!(user_id: 1, comment_id: 1, reply_content: "Like")
