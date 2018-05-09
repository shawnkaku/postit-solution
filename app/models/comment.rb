class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :votes, as: :voteable
  # has_many :users, through: :posts
  validates :body, presence: true, length: {minimum: 5}
end