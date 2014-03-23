class SmsController < ApplicationController
  include GroovesharkSearchHelper

  TWILIO_PHONE_NUMBER = '9083005599'

  def req
    @client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
    @all_messages = @client.account.messages.list
    @current_message_body = @client.account.messages.list[0].body
    @current_message_sender = @client.account.messages.list[0].from

    unless @current_message_sender == "+19083005599"

      if #phone number is NOT in User Database
        #create user in database
          reply(" ")
        if #user is joining a party
          #run joinparty methods
          reply("Welcome to party. ")
      end

      if #User is in a party
        getGrooveShark
        reply("Your song has been added to the queue")
      elsif #User is not in a party (but in db)
        if #the user's message is #wagparty
          #find party by message and add user
          #reply "CONGRATS HOMIE. reply for requests"
        else #the user's message is rando
          reply("Fuck youuu")
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