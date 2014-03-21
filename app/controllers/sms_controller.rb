class SmsController < ApplicationController
  
  TWILIO_PHONE_NUMBER = '9083005599'

  def req
    @client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
    @all_messages = @client.account.messages.list
    #@current_message_object = @client.account.messages.list[0]
    @current_message_sender = @client.account.messages.list[0].from
    @current_message_body = @client.account.messages.list[0].body
    unless @current_message_sender == "+19083005599"
      reply
    end

    render ('index')
  end

  def reply
    # number_to_send_to = params[:number_to_send_to]
    number_to_send_to =  @client.account.messages.list[0].from
    @last_guest_message_body = @client.account.messages.list[0].body
    @twilio_client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
    @twilio_client.account.sms.messages.create(
      :from => "+1#{TWILIO_PHONE_NUMBER}",
      :to => number_to_send_to,
      :body => "Thanks for Requesting: #{@last_guest_message_body}. Welcome to the Party."
    )
  end
end