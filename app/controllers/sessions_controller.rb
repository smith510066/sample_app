class SessionsController < ApplicationController
	
	def new
	end
	def show
	end
	
	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			flash[:works] = "You are now authenticated"
			sign_in user
			redirect_to user_path(user)
			#redirect_to('/')
		else
			flash.now[:error] = "Wrong username and/or password combination"
			render 'new'
		end
	end

	def destroy
		sign_out
	  	flash[:success] = "You successfully signed out"
	  	redirect_to "/"
	end

end
