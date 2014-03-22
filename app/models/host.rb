class Host < ActiveRecord::Base
  self.has_secure_password()
  belongs_to :user
end
