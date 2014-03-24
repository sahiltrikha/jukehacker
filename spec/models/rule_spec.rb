require 'spec_helper'

describe Rule do
  it {should have_and_belong_to_many(:parties)}
  it {should validate_presence_of(:condition)}
  it {should validate_presence_of(:banned_value)}
  it {should validate_uniqueness_of(:condition)}
  it {should validate_uniqueness_of(:banned_value)}
end
