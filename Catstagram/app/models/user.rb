class User < ActiveRecord::Base
  has_many :photos, {:dependent => :destroy}
  has_many :cats
  
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
