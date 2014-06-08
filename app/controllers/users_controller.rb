class UsersController < ApplicationController
  # use a before 'filter' to control access to edit/update 
  # only for signed in users
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers ]
  # and for thr correct user
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]
  
  # id available via RESTful URl ala /users/[:id]/show
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  # id available via RESTful URl ala /users/[:id]/edit
  def edit
    @user = User.find(params[:id])
  end
  
  # grab a page of users and assign them to an instance variable @users
  # :page parameter is generated by 'will_paginate'
  def index
    @users = User.paginate(page: params[:page])
  end
  
  # put new User in instance variable @user
  def new
    @user = User.new
  end
  
  
  def create
    # :user is label for hash of hashes user=>{"name" => "value"}
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def update 
    @user = User.find(params[:id])
    # user_params is submitted hash of User attributes
    if @user.update_attributes(user_params)
      # handle a sucessfule update
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      # re-render the edit page if update unsuccessful
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private
  
    # use strong paramters to constrain :user hash
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    # before filters
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  
end
