class UsersController < ApplicationController
  before_filter :authenticate, except: [:show, :new, :create]
  before_filter :correct_user, only: [:edit, :update, :disable]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :adminpanel, :disable]
  before_action :set_envios, only: [:show]
  before_filter :admin_user, only: [:destroy, :adminpanel]
  
  def index
    @users = User.paginate(:page => params[:page])
    @title = "All Users "
  end
  
  def adminpanel
   @title = "Admin Panel"
   @newuser = User.new
  end

  def show
	  @title = @user.name
  end

  def following
    @title = " - Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = " - Following"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end

  def new
    @user = User.new
    @title = "Sign up"
  end

  def create
    if current_user.nil?
     @user = User.new(user_params)
      if @user.save 
        sign_in @user
        redirect_to user_path(@user), :flash => {:success => "User created."} unless current_user.admin?
      else
        @title = "Sign up"
        render 'new'
      end
    else
     flash[:notice] = "You are already registered. " if !current_user.admin?  
     redirect_to root_path unless current_user.admin?
     if current_user.admin?
        @newuser = User.new(user_params)
        if @newuser.save 
          flash[:notice] = "User created. "
          redirect_to adminpanel_user_path(current_user)
        else
          flash[:error] = "Failed. "
          redirect_to adminpanel_user_path(current_user)
      end
     end
    end
   end 

  def edit
    @title = "Edit user" 
  end
  def update
     if params[:admin]=0 || (params[:admin]=1 && current_user.admin?)
      if @user.update_attributes(user_params)
        redirect_to @user, :flash =>{:success => "User information changed."}
      else
        render 'edit'
        @title = "Edit user"
      end
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
  private
    def authenticate
      deny_access unless signed_in? 
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) || current_user.admin? 
    end
    def set_user
      @user = User.find(params[:id])
    end
    def set_envios
      @envios= @user.envios.paginate(:page => params[:page])
    end
    def admin_user
      redirect_to(root_path) unless current_user.admin? 
      flash[:notice] = "You have no permission to access this page. " if !current_user.admin?
    end
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :lastname, :admin) 
    end
end