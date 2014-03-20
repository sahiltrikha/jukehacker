class SmsController < ApplicationController
  
  # base URL of this application
  BASE_URL = "http://www.yourserver.com:3000/sms"
  TWILIO_PHONE_NUMBER = '9083005599'

  def req
    @client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
    #@all_messages = @client.account.messages.list
    #@current_message_object = @client.account.messages.list[0]
    @current_message_body = @client.account.messages.list[0].body
    
    render :index
  end

  # def reply
  #   # number_to_send_to = params[:number_to_send_to]
  #   number_to_send_to = '5129052044'
 
  #   @twilio_client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
  #   binding.pry
 
  #   @twilio_client.account.sms.messages.create(
  #     :from => "+1#{TWILIO_PHONE_NUMBER}",
  #     :to => number_to_send_to,
  #     :body => "This is an message. It gets sent to #{number_to_send_to}"
  #   )
  # end
end