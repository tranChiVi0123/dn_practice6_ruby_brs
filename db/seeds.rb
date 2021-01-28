# User created
User.create!(name: "Admin",
            email: "admin@example.com",
            role: 0)
10.times do |n|
  name = "User#{n}"
  email = "user#{n}@example.com"
  role = 1
  User.create!(name: name, email: email, role: role)
end

# Create following relationships.
users = User.all
user = users.first
following = users[2..5]
followers = users[3..8]
following.each{|followed| user.follow(followed)}
followers.each{|follower| follower.follow(user)}

Category.create!(name: "Fiction")
Category.create!(name: "Technology")

10.times do |n|
  title = "Book #{n}"
  description = "Description #{n}"
  image = "app/asset/img/img-#{n}"
  published_time = "23/1//1998"
  page_num = 10
  author = "Author#{n}"
  category_id = 1
  Book.create!(title: title, description: description, image: image,
    published_time: published_time, page_num: page_num,
    author: author, category_id: category_id)
end

UserBook.create!(user_id: 1, book_id: 1, status: 1, rating_point: 9.5)
Review.create!(user_id: 1, book_id: 2, review_content: "Great Book")
Comment.create!(user_id: 2, review_id: 1, comment_content: "Ok Bro!")
Reply.create!(user_id: 1, comment_id: 1, reply_content: "Like")
