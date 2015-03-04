class SessionsController < ApplicationController
  def new
  end

  def new_auth
  end

  def boom
  end

def create
  puts
  "*"*100
  "create"
  user = User.authenticate(params[:username], params[:password])
  if user
    puts "if"
    user.generate_code
    redirect_to new_auth_path
  else
    puts "else"
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
end
