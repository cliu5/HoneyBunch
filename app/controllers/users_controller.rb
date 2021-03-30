class UsersController < ApplicationController
    
  skip_before_action :authorized, only: [:new, :create]

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def new
      @user = User.new
  end

  def create
    @user = User.create(user_params) #changed
    session[:user_id] = @user.id
    #puts user_params
    redirect_to '/stores'
  end
  
end
