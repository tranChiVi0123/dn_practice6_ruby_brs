class Book < ApplicationRecord
  belongs_to :category
  has_many :user_books, dependent: :destroy
  has_many :reviews, dependent: :destroy
end
