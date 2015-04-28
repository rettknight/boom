class UsersController < ApplicationController
  before_filter :authenticate, only: [:edit, :update, :index, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :admin_user, only: [:destroy]
  
  def index
    @users = User.paginate(:page => params[:page])
    @title = " - All Users "
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
    if @user.admin? 
      redirect_to root_path, :flash => {:error => "Admins can't delete themselves. "} 
    else
      @user.destroy
      redirect_to users_path, :flash => {:success => "User deleted."}  
    end
  end

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
    #require :user - important, allows it to be created
  end

  private
    def authenticate
      deny_access unless signed_in? 
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def set_user
      @user = User.find(params[:id])    
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin? 
    end
end