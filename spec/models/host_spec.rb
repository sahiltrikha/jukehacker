require 'spec_helper'

describe Host do
  it { should belong_to(:user) }
  it { should have_many(:parties)}
end
