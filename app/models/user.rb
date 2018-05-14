class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments, through: :posts

  has_secure_password validations: false

  # extend FriendlyId
  # friendly_id :id, use: :slugged

  # def normalize_friendly_id(input)
  #   input.to_s.to_slug.normalize.to_s
  # end
  # def should_generate_new_friendly_id?
  #   # binding.pry
  #   slug.blank? || username_changed? # slug 為 nil 或 name column 變更時更新
  # end
  def slug_candidates
    [:id,  [:id, :username]]
  end
  def admin?
    self.role.to_s.to_sym == :admin
  end

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}
end