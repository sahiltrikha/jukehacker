class User < ActiveRecord::Base
  has_one :host
end
