class AdminsController < ApplicationController
    def new
        @user = User.new
        render "users/new"
    end
  
    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to root_url, :notice => "Signed up!"
        else
            render "new"
        end
    end

  	private

  	def user_params
  		params.require(:user).permit(:name, :username, :celphone, :email, :password)
  	end

end