require 'twilio-ruby'

class UsersController < ApplicationController

    include Webhookable
 
    after_filter :set_header
 
    skip_before_action :verify_authenticity_token
  
    def new
        response.headers["Content-Type"] = "application/html"
        @user = User.new
        render "new"
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
            r.Say 'Hello ' + user.name + ' your code is ', :voice => 'alice'
            r.Pause :length => 3
            user.code.to_s.split('').each do |digit|
                r.Say digit, :voice => 'alice'
                r.Pause :length => 1   
            end
        end
        render_twiml response
    end

  	private

  	def user_params
  		params.require(:user).permit(:name, :username, :celphone, :email, :password)
  	end

end