class Post < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_id
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}

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