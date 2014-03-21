class SmsController < ApplicationController
  include GroovesharkSearchHelper

  TWILIO_PHONE_NUMBER = '9083005599'

  def req
    @client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
    @all_messages = @client.account.messages.list
    @current_message_body = @client.account.messages.list[0].body
    @current_message_sender = @client.account.messages.list[0].from

    unless @current_message_sender == "+19083005599"
      if User.find_by(phone_number: @current_message_sender).nil? == true #phone number is NOT in User Database
        @current_user = User.create(phone_number: @current_message_sender)  #create user in database
      else
        @current_user = User.find_by(phone_number: @current_message_sender)
      end
      ##### THIS DOESNT WORK FOR EXPIRED PARTIES!!!! fix
      if Guest.find_by(user_id: @current_user.id).nil? == false #User is in a party (they have been validadted with a party key)
        current_guest_info = Guest.find_by(user_id: @current_user.id)
        current_party_id = current_guest_info.party_id
        reply("Your song, #{@current_message_body}, has been added to the queue")
        getGrooveshark("#{@current_message_body}", current_party_id, @current_user.id)
      elsif Guest.find_by(user_id: @current_user.id).nil? == true #User is not in a party (they are not a guest but they are a user in the database)
        if Party.find_by(party_key: @current_message_body).nil? == false #the user's message is #wagparty
          current_party = Party.find_by(party_key: @current_message_body)
          Guest.create(user_id: @current_user.id, party_id: current_party.id)#find party by message and add user
          reply("Congrats! You've Joined #{current_party.party_key}")#reply "CONGRATS HOMIE. reply for requests"
        else #the user's message is rando
          reply("You mad bro?")
        end
      end

    end

    render ('index')
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
end