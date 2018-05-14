module Sluggable
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
      friendly_id :id, use: :slugged

    def normalize_friendly_id(input)
      input.to_s.to_slug.normalize.to_s
    end
    def should_generate_new_friendly_id?
      # slug 為 nil 或 name column 變更時更新
      slug.blank? || id_changed?
    end
  end

end