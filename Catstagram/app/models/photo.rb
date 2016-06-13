class Photo < ActiveRecord::Base
  has_and_belongs_to_many :hashtags
  has_and_belongs_to_many :cats
  belongs_to :user
  
  mount_uploader :image_url, ImageUploader
  
  validates_processing_of :image_url
  validate :image_size_validation

  # returns true if a picture is reported.
  def is_reported?
    (report_count > 0)
  end

  # returns true if a picture is newer than 5 min (for the purpose of the presentation)
  def is_new?
    (created_at > Time.now - 5.minutes)
  end
  
  private
    def image_size_validation
      errors[:image_url] << " should be less than 1MB" if image_url.size > 1.megabytes
    end
end
