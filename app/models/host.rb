class Host < ActiveRecord::Base
  self.has_secure_password()
  belongs_to :user
  has_many :parties

  # validations
  validates :email, uniqueness: true, presence: true
  validates :user_id, uniqueness: true, presence: true

end
