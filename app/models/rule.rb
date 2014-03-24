class Rule < ActiveRecord::Base
  has_and_belongs_to_many :parties
  validates :condition, presence: true, uniqueness: true
  validates :banned_value, presence: true, uniqueness: true
end
