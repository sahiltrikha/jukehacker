require 'spec_helper'

describe User do
  it { should have_one(:host) }
  it { should have_many(:guests)}
end
