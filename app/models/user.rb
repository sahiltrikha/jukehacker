class User < ActiveRecord::Base
  has_one :host
  has_many :guests
end
