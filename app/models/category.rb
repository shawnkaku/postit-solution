class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true

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
    [ :id, [:id, :name]]
  end
end