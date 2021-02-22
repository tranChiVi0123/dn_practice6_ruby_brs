class Notification < ApplicationRecord
  belongs_to :user
  enum status: {not: 0, seen: 1}
end
