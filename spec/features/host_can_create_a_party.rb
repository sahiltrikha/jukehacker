require 'spec_helper'

describe "host can create a party" do

	it "creates a party" do
		visit('/partycreate')
		fill_in 'party_party_key', with: "Test Party"
    click_button 'Rock On'
    expect(page).to have_content("Test Party")
	end

end
