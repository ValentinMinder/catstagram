class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :photos, {:dependent => :destroy}
  has_many :cats

  has_and_belongs_to_many :roles

  mount_uploader :avatar_url, ImageUploader
  
  validates_processing_of :avatar_url
  validate :image_size_validation

  # check role
  def has_role?(role)
    return self.roles.find_by(:name => role.to_s.camelize)
  end

  # check admin role
  def is_admin? 
    return self.has_role?(:admin)
  end

  # check user role
  def is_user? 
    return self.has_role?(:user)
  end

  # check tester role
  def is_tester? 
    return self.has_role?(:tester)
  end

  #Returns if there are reported photos (it is the only model accessible everywhere!)
  def has_reported_photo?
    return (Photo.where("report_count > 0").size > 0)
  end

  #Returns the number of reported photos (it is the only model accessible everywhere!)
  def number_reported_photo?
    return Photo.where("report_count > 0").size
  end

  #Returns the number of banned users photos (it is the only model accessible everywhere!)
  def number_banned_users?
    User.all.select{ |u| u.is_banned }.size
  end

  def roles_as_text
    text = ''
    self.roles.each do |role|
      text += role.name + " "
    end
    return text
  end
  
  ## Checks if a user is banned given its banned_until value
  def is_banned
  	if (nil == banned_until) then
  	  false
    elsif (Time.now <= banned_until) then
      true
    else
      false
    end
  end

  def image_size_validation
    errors[:avatar_url] << " should be less than 5MB" if avatar_url.size > 5.megabytes
  end
end
