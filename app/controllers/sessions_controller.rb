class SessionsController < ApplicationController


	def new
		render :layout => 'signin_layout'
  	end

	def create
	  user = login(params[:session][:username], params[:session][:password])
	  if user && user.active
	    redirect_back_or_to root_url, :notice => "Logged in!"
	  else
	    flash.now[:error] = "Username or password was invalid"
	    render :new, :layout => 'signin_layout'
	  end
	end

	def destroy
	  logout
	  redirect_to root_url, :notice => "Logged out!"
	end
end
