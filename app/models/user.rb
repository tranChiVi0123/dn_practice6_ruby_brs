class User < ApplicationRecord
  has_many :user_books, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :nofitications, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: :follower_id,
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: :followed_id,
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  enum role: [:guest, :user, :admin]

  # Follows a user.
  def follow other_user
    following << other_user
  end

  # Unfollows a user.
  def unfollow other_user
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following? other_user
    following.include?(other_user)
  end
end
