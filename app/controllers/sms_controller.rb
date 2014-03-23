class SmsController < ApplicationController
  include GroovesharkSearchHelper

  TWILIO_PHONE_NUMBER = '9083005599'

  def req
    @client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
    @all_messages = @client.account.messages.list
    @current_message_body = @client.account.messages.list[0].body
    @current_message_body.downcase!
    @current_message_sender = @client.account.messages.list[0].from

    unless @current_message_sender == "+19083005599"
      if User.find_by(phone_number: @current_message_sender).nil? == true #phone number is NOT in User Database
        @current_user = User.create(phone_number: @current_message_sender)  #create user in database
      else
        @current_user = User.find_by(phone_number: @current_message_sender)
      end



      if Party.find_by(party_key: @current_message_body).present? #If user texts a proper party key
        current_party = Party.find_by(party_key: @current_message_body)
        if Time.now > current_party.party_expiry
          reply("Sorry sir, the party has ended.")
        else
          Guest.create(user_id: @current_user.id, party_id: current_party.id)#find party by message and add user
          reply("Congrats! You've joined #{current_party.party_key}. Text back #queue to see the current play list, or text back a song to add to the queue.")#reply "CONGRATS HOMIE. reply for requests"
        end


      ##guest has joined a party at this point
      elsif Guest.where(user_id: @current_user.id).last
        current_guest_info = Guest.where(user_id: @current_user.id).last
        current_party_id = current_guest_info.party_id
        @current_party = Party.find_by(id: current_party_id)
        if Time.now < @current_party.party_expiry
          if @current_message_body == "#queue"
            return_queue
          else
            reply("Your song, #{@current_message_body}, has been added to the queue")
            getGrooveshark("#{@current_message_body}", current_party_id, @current_user.id)
          end
        else
          reply("You cannot add any more songs, party is over. Stay safe!")
        end
      else
        reply("Don't send us garbage!")
      end
    end
  end



  def reply(message)
    number_to_send_to = @current_message_sender
    @twilio_client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
    @twilio_client.account.sms.messages.create(
      :from => "+1#{TWILIO_PHONE_NUMBER}",
      :to => number_to_send_to,
      :body => "#{message}"
      )
  end

  def return_queue
    message = [];
    # @queued_songs = QueuedSong.where(party_id: @current_party.id)
    @queued_songs = @current_party.queued_songs.order(total_votes: :desc)
    @songs = @queued_songs.map do |queued_song|
      Song.find(queued_song.song_id)
    end
    @songs.each_with_index do |song, index|
      message << (index+1) + " " + song.title
    end



    reply(message.join(" "))
  end

end






