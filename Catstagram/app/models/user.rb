class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :photos, {:dependent => :destroy}
  has_many :cats

  has_and_belongs_to_many :roles

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
end
