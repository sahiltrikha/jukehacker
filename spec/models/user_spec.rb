require 'spec_helper'

describe User do
  it { should have_one(:host) }
  it { should have_many(:guests)}
  it{should validate_presence_of(:phone_number)}
  it{should validate_uniqueness_of(:phone_number)}
end
