class Vote < ActiveRecord::Base
  belongs_to :users, foreign_key: 'user_id'
  belongs_to :voteable, polymorphic: true
end