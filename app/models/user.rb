class User < ActiveRecord::Base

  self.has_secure_password()
  
end
