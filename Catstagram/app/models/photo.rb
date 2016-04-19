class Photo < ActiveRecord::Base
  has_and_belongs_to_many :hashtags
  has_and_belongs_to_many :cats
  belongs_to :user
end
