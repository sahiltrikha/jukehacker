require 'spec_helper'
require 'pry'

describe "a host can view their party dashboard" do 
  let(:user) {User.create(:phone_number=>6103315577, :first_name=>"Michael", :last_name=>"Wagner") }
  # let(:host) {Host.create(:user_id=>user.id, :email=>"michael.k.wagner@gmail.com", :password=>"winner", :zip=>10128) }
  let(:party) {Party.create(:party_key=>"#WagParty", :party_expiry=>03/20/14) }
  
  let(:song1) {Song.create(:grooveshark_id=>408271, :title=>"Oxford Comma", :artist=>"Vampire Weekend", :length=>196)}
  let(:queued_song1) {Queued_Song.create(:party_id=> party.id, :song_id=> song1_id, :user_id=> user.id, :upvotes=>0, :downvotes=>0)}

  let(:song2) {Song.create(:grooveshark_id=>936496, :title=>"Me and Julio down by the School", :artist=>"Paul Simon", :length=>163)}

  let(:queued_song2) {Queued_Song.create(:party_id=> party.id, :song_id=> song2_id, :user_id=> user.id, :upvotes=>0, :downvotes=>0)}

  let(:song3) {Song.create(:grooveshark_id=>25133412, :title=>"Enter Sandman", :artist=>"Metallica", :length=>163)}
  
  # let(:queued_song3) {Queued_Song.create(:party_id=> party.id, :song_id=> song3_id, :user_id=> user.id,:upvotes=>0, :downvotes=>0)}

  # it "host can view their queued songs" do
  #   visit '/party-dashboard/'+"#{party.id}"
  #   expect(page).to have_content(song1.title)
  #   expect(page).to have_content(song2.title)
  #   expect(page).not.to have_content(song3.title)
  # end 

  # def login(host)
  #   visit "/"
  #   fill_in :email, with: host.email
  #   fill_in :password, with: host.password
  #   click_button "Log in!"
  # end

  # def create_party
  #   visit "/partycreate"
  #   ###
  #   ###
  #   ###
  # end



end 


