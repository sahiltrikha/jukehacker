class User < ActiveRecord::Base
  has_one :host
  has_many :guests
  validates :phone_number, presence: true, uniqueness: true
end
