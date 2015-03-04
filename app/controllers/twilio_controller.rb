require 'twilio-ruby'
 
class TwilioController < ApplicationController

    include Webhookable
 
    after_filter :set_header
 
    skip_before_action :verify_authenticity_token

   # def voice
    #    account_sid = 'AC3b1f7f5063c36b58df1184eeee14bed4' 
    #    auth_token = 'e3a6b88c86ad73da59d08a58817a2f0c' 
    #    @client = Twilio::REST::Client.new account_sid, auth_token 
    # 
    #    @client.account.calls.create({
    #        :url => 'http://magic-login.herokuapp.com/twilio/text_response' ,
    #        :to => "+14158406242",
    #        :from => '+16504828142'  
    #    })
    #    render nothing: true
#
    #end 

    def self.voice(user)
        account_sid = 'AC3b1f7f5063c36b58df1184eeee14bed4' 
        auth_token = 'e3a6b88c86ad73da59d08a58817a2f0c' 
        @client = Twilio::REST::Client.new account_sid, auth_token 
     
        @client.account.calls.create({
            :url => 'http://magic-login.herokuapp.com/twilio/text_response/'+user.id ,
            :to => user.celphone,
            :from => '+16504828142'  
        })
        render nothing: true

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

    def text_response
        user = User.find(params[:id])
        response = Twilio::TwiML::Response.new do |r|
            r.Say 'Hello ' + user.name + ' your code is ' + spell_number(user.code), :voice => 'alice'
        end
        render_twiml response
    end

    def spell_number(number)
        spelled_number = ""
        number.to_s.split('').each do |number|
            spelled_number = spelled_number + number +  ' '
        end
        return spelled_number
    end

end