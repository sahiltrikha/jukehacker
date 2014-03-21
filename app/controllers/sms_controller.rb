class SmsController < ApplicationController
  
  # base URL of this application
  BASE_URL = "http://www.yourserver.com:3000/sms"
  TWILIO_PHONE_NUMBER = '9083005599'

  def req
    @client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
    @all_messages = @client.account.messages.list
    #@current_message_object = @client.account.messages.list[0]
    @current_message_sender = @client.account.messages.list[0].to
    @current_message_body = @client.account.messages.list[0].body
    reply
    render :index
  end

  def reply
    # number_to_send_to = params[:number_to_send_to]
    number_to_send_to = @current_message_sender
 
    @twilio_client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
 
    @twilio_client.account.sms.messages.create(
      :from => "+1#{TWILIO_PHONE_NUMBER}",
      :to => number_to_send_to,
      :body => "Thanks for Requesting: #{@current_message_body}. Welcome to the Party."
    )
  end
end