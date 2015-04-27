class SessionsController < ApplicationController
  def new
  	@title = "Sign in"
  end
  def create
  	user = User.authenticate(params[:session][:email],
  							 params[:session][:password])
  	if user.nil?
  		flash.now[:error] = "Invalid email/password."
  		@title = "Sign in"
  		render 'new'
  	else	
  		#Success
  	end
  end
  def destroy
  	
  end

  def session_params
  	session_params.require(:session).permit(:email,:password)
  end
end
