class Request < ApplicationRecord
  belongs_to :user
  enum status: [:processing, :processed]
end
