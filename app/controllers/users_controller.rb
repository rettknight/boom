class UsersController < ApplicationController
  before_filter :authenticate, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def set_user
    @user = User.find(params[:id])    
  end

  def show
	@title = "- "+@user.name
  end

  def new
   @user = User.new
   @title = "- Sign up"
  end

  def create
   	@user = User.new(user_params)
		if @user.save
      sign_in @user
			redirect_to user_path(@user), :flash => {:success => "User created."}
		else
			@title = "- Sign up "
			render 'new'
		end
   end 

  def edit
       @title = "- Edit user" 
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to @user, :flash =>{:success => "User information changed."}
    else
      render 'edit'
      @title = "- Edit user"
    end
  end

  def destroy
    
  end

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
    #require :user - important, allows it to be created
  end

  private
    def authenticate
      deny_access unless signed_in? 
    end
end