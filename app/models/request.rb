class Request < ApplicationRecord
  belongs_to :user
  enum status: {processing: 0, processed: 1}
end
