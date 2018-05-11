class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :votes, as: :voteable
  # has_many :users, through: :posts
  validates :body, presence: true, length: {minimum: 5}

  extend FriendlyId
  friendly_id :id, use: :slugged
  # 原本是input.to_s.parameterize，但是parameterize只支援英文跟數字，所以改用babosa的to_slug
  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end
  def should_generate_new_friendly_id?
    slug.blank? || id_changed? # slug 為 nil 或 name column 變更時更新
  end
  def slug_candidates
    [ :id, [:id, :body]]
  end

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