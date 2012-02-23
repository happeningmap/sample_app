class UsersController < ApplicationController
  
  before_filter :authenticate, :only => [:edit, :update, :index]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  
  def index
      @title = " | All users"
      @users = User.paginate(:page => params[:page], :per_page => 13, :order => 'name ASC')
  end
    
  def destroy
    name = User.find(params[:id]).name
    User.find(params[:id]).destroy
    flash[:success] = "User #{name} destroyed"
    redirect_to users_path
  end

  
  def new
      @user = User.new
      @title = " | Sign up"
    end
  
  def show
      @user = User.find(params[:id])
      @title = " | " + @user.name
  end
  
  def edit
    #  @user = User.find(params[:id]) defined in correct_user
      @title = " | Edit user"
  end
  
  def update
    #  @user = User.find(params[:id]) defined in correct_user
      if @user.update_attributes(params[:user])
        flash[:success] = "Profile updated."
        redirect_to @user
      else
        @title = " | Edit user"
        render 'edit'
      end
  end
  
  def create
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to happeningmap!"
        redirect_to @user
      else
        @title = " | Sign up"
        render 'new'
      end
    end
    
    private

        def authenticate
          deny_access unless signed_in?
        end
        
        def correct_user
              @user = User.find(params[:id])
              redirect_to(root_path) unless current_user?(@user)
        end
        
        def admin_user
          
          if current_user.nil?
            redirect_to(signin_path)
          else
            redirect_to(root_path) unless current_user.admin?  
          end

        end
    
    
  
end
