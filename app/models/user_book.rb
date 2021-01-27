class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book
  enum status: [:unread, :reading, :read]
end
