require 'twilio-ruby'

class UsersController < ApplicationController

    include Webhookable
 
    after_filter :set_header
 
    skip_before_action :verify_authenticity_token
  
    def new
        @user = User.new
    end
  
    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to root_url, :notice => "Signed up!"
        else
            render "new"
        end
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

  	private

  	def user_params
  		params.require(:user).permit(:name, :username, :celphone, :email, :password)
  	end

end