require 'spec_helper'

describe Guest do
  it{should belong_to(:user)}
  it{should belong_to(:party)}
end
