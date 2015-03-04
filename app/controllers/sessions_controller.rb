class SessionsController < ApplicationController
  
    def new
    end

    def new_auth
    end

    def boom
    end

    def create
        user = User.authenticate(params[:username], params[:password])
        if user
            user.generate_code
            spell_number(user.code)
            redirect_to new_auth_path
        else
            flash.now.alert = "Invalid email or password"
            render "new"
        end
    end

    def create_session
        user = User.authenticate(params[:username], params[:password])
        session[:user_id] = user.id
        redirect_to root_url, :notice => "Logged in!"
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url, :notice => "Logged out!"
    end

    def spell_number(number)
        spelled_number = ""
        number.to_s.split('').each do |number|
            spelled_number = number +  ' '
        end
        puts spelled_number
    end
end