class SessionsController < ApplicationController

  skip_before_action :authorized, only: [:new, :create, :welcome]
  
  def new
      @user = User.new
  end

  def create
    @user = User.create(params.require(:user).permit(:username, :password))
    session[:user_id] = @user.id
    redirect_to '/stores'
  end
    

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
        log_in user
        redirect_to '/stores'
    else
      redirect_to '/welcome'
    end
  end
    
  def destroy
    log_out
    redirect_to '/welcome'
  end

  def welcome
    @user = User.new
  end

  def login
  end

  def page_requires_login
  end
  
end