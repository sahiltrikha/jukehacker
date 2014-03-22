require 'spec_helper'

describe Host do
  it { should belong_to(:user) }
end
