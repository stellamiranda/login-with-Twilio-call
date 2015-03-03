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
    render "new_auth"
  else
    flash.now.alert = "Invalid email or password"
    render "new"
  end
end

def create_session
  session[:user_id] = user.id
  redirect_to root_url, :notice => "Logged in!"
end

def destroy
  session[:user_id] = nil
  redirect_to root_url, :notice => "Logged out!"
end
end
