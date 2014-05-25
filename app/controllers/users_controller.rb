class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  
  def new
    @user = User.new
  end
  
  
  def create
    # :user is label for hash of hashes user=>{"name" => "value"}
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private
  
  # use strong paramters to constrain :user hash
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
