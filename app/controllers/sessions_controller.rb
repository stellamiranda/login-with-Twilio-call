class SessionsController < ApplicationController
  
    def new
    end

    def new_auth
        puts session[:user_id]
    end

    def boom
    end

    def create
        user = User.authenticate(params[:username], params[:password])
        if user
            session[:user_id] = user.id
            user.generate_code
            user.voice
            redirect_to new_auth_path
        else
            flash.now.alert = "Invalid username or password"
            render "new"
        end
    end

    def create_session
        user = User.find(session[:user_id])
        if user
            if user.code.to_s == params[:code]
                redirect_to boom_path, :notice => "Logged in!"
            else
                flash.now.alert = "Invalid Code"
                render "new_auth"
            end
         else
            flash.now.alert = "Invalid username or password"
            render "new"
        end

    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url, :notice => "Logged out!"
    end

   
end