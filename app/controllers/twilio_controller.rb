require 'twilio-ruby'
 
class TwilioController < ApplicationController

    include Webhookable
 
    after_filter :set_header
 
    skip_before_action :verify_authenticity_token
    # put your own credentials here 

    def voice
        account_sid = 'AC3b1f7f5063c36b58df1184eeee14bed4' 
        auth_token = 'e3a6b88c86ad73da59d08a58817a2f0c' 
        @client = Twilio::REST::Client.new account_sid, auth_token 
     
        @client.account.calls.create({
            :url => 'http://magic-login.herokuapp.com/twilio/voice2' ,
            :to => "+14158406242",
            :from => '+16504828142'  
        })
        render nothing: true

    end 

    def text_response
        Twilio::TwiML::Response.new do |r|
            r.Say "your code is 1 2 3 4 5 6"
        end.text
    end

    def sms 
        account_sid = 'AC3b1f7f5063c36b58df1184eeee14bed4' 
        auth_token = 'e3a6b88c86ad73da59d08a58817a2f0c' 
        @client = Twilio::REST::Client.new account_sid, auth_token 
         
        @client.account.messages.create({
            :body => "Hello World",
            :to => "+573005787275",
            :from => '+16504828142'  
        })
    end

    def voice2
        response = Twilio::TwiML::Response.new do |r|
            r.Say 'r.Say "your code is 1 2 3 4 5 6 ', :voice => 'alice'
        end
        render_twiml response
    end

    def voice3
        Twilio::TwiML::Response.new do |r|
            r.Say 'Hello Monkey'
        end.text
    end

end