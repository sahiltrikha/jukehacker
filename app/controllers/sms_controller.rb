class SmsController < ApplicationController
  include GroovesharkSearchHelper

  TWILIO_PHONE_NUMBER = '9083005599'

  def req
    @client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
    @current_message_body = @client.account.messages.list[0].body.downcase!
    @current_message_sender = @client.account.messages.list[0].from

    #to specify twilio's incoming messages (not outgoing responses)
    unless @current_message_sender == "+19083005599"
      
      @current_user = get_current_user

      #If user texts a proper party key
      if Party.find_by(party_key: @current_message_body).present?
        current_party = Party.find_by(party_key: @current_message_body)
        
        #if party is expired
        if Time.now > current_party.party_expiry
          reply("Sorry sir, the party has ended.")
        else
          #find party by message and add user as guest
          Guest.create(user_id: @current_user.id, party_id: current_party.id)
        ##if HOUSE RULES are fine
          #reply confirming party entrance"
          reply("Congrats! You've joined #{current_party.party_key}. Text back #queue to see the current play list, or text back a song to add to the queue.")
        end


      ##guest has joined a party at this point
      elsif Guest.where(user_id: @current_user.id).last
        current_guest_info = Guest.where(user_id: @current_user.id).last
        current_party_id = current_guest_info.party_id
        @current_party = Party.find_by(id: current_party_id)

        if Time.now < @current_party.party_expiry
          if @current_message_body == "#queue"
            return_queue
          elsif @current_message_body.include?("#upvote")
            upvote
          elsif @current_message_body.include?("#downvote")            
            downvote
          else
            # reply("Your song, #{@current_message_body}, has been added to the queue")
            confirmation_message = getGrooveshark("#{@current_message_body}", current_party_id, @current_user.id)
            reply(confirmation_message)
          end
        else
          reply("You cannot add any more songs, party is over. Stay safe!")
        end
      else
        reply("Don't send us garbage!")
      end
    end
  end

  def upvote
    message = @current_message_body.split(" ")
    message_num = message[1].to_i
    queued_songs = @current_party.queued_songs.order(total_votes: :desc)
    upvoted_song = queued_songs[message_num-1]
    upvoted_song.upvotes += 1
    upvoted_song.total_votes += 1
    upvoted_song.save
    reply("Thanks for upvoting!")
  end
  def downvote
    message = @current_message_body.split(" ")
    message_num = message[1].to_i
    queued_songs = @current_party.queued_songs.order(total_votes: :desc)
    upvoted_song = queued_songs[message_num-1]
    upvoted_song.upvotes -= 1
    upvoted_song.total_votes -= 1
    upvoted_song.save
    reply("Thanks for downvoting!")
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
      message << (index+1).to_s + " " + song.title
    end
    reply(message.join(" "))
  end

  def get_current_user
    #phone number is NOT in User Database
    if User.find_by(phone_number: @current_message_sender).nil?
      #create user in database
      return current_user = User.create(phone_number: @current_message_sender)
    else
      #look up user in database
      return current_user = User.find_by(phone_number: @current_message_sender)
    end
  end

end






