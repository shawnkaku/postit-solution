class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :votes, as: :voteable
  # has_many :users, through: :posts
  validates :body, presence: true, length: {minimum: 5}

  def vote_total
    vote_up - vote_down
  end
  def vote_up
    self.votes.where(vote: true).size
  end
  def vote_down
    self.votes.where(vote: false).size
  end
end