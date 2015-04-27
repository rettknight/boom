class UsersController < ApplicationController

  def show
	@user = User.find(params[:id])  	
	@title = "- "+@user.name
  end

  def new
   @user = User.new
   @title = "- Sign Up!"
  end

  def create
   	@user = User.new(user_params)
	if @user.save
		#Success
	else
		render 'new'
	end
  end

  def user_params
  	params.permit(:name, :email, :password, :password_confirmation)
  end
end
