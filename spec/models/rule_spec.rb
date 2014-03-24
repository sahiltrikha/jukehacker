require 'spec_helper'

describe Rule do
  it {should have_and_belong_to_many(:parties)}
end
