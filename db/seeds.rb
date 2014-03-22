# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Host.destroy_all
Party.destroy_all
Song.destroy_all
QueuedSong.destroy_all

user1 = User.create(
  phone_number: "+16103315573", 
  first_name: "Michael", 
  last_name: "Wagner"
  )

host = Host.create(
  user_id: user1.id, 
  email: "michael.k.wagner@gmail.com", 
  password: "winner", 
  password_confirmation: "winner",
  zip: 10128,
  )

party1 = Party.create(
  host_id: host.id, 
  party_key: "#wagparty", 
  party_expiry: Time.now + 5*60 
  )

song1 = Song.create(
  grooveshark_id: 408271,
  title: "Oxford Comma",
  artist: "Vampire Weekend",
  duration: 196000
  )

song2 = Song.create(
  grooveshark_id: 936496,
  title: "Me and Julio down by the School",
  artist: "Paul Simon",
  duration: 163000
  )

song3 = Song.create(
  grooveshark_id: 25133412,
  title: "Enter Sandman",
  artist: "Metallica",
  duration: 332000
  )

queue_song1 = QueuedSong.create(
  party_id: party1.id, 
  song_id: song1.id, 
  user_id: user1.id, 
  upvotes: 0, 
  downvotes: 0 
  )

queue_song2 = QueuedSong.create(
  party_id: party1.id, 
  song_id: song2.id, 
  user_id: user1.id, 
  upvotes: 0, 
  downvotes: 0 
  )

queue_song3 = QueuedSong.create(
  party_id: party1.id, 
  song_id: song3.id, 
  user_id: user1.id, 
  upvotes: 0, 
  downvotes: 0 
  )

